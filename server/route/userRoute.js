const express = require('express')
const jwt = require('jsonwebtoken')
const router = express.Router();
const connection = require('../db');
const JWT_KEY = "secret_key";
const multer = require('multer');
const path = require('path');



router.route("/")
  .get((req, res) => {
    const query = 'SELECT * FROM tbl_user';
    connection.query(query, (err, results) => {
      if (err) {
        console.error('쿼리 실행 실패:', err);
        // res.status(500).send('서버 오류');
        return;
      }
      res.json({ success: true, list: results });
    });
  })
  .post((req, res) => {
    const { email, password } = req.body;
    const query = 'SELECT * FROM tbl_user WHERE user_id = ? AND pwd = ?';
    connection.query(query, [email, password], (err, results) => {
      if (err) throw err;
      if (results.length > 0) {
        // 로그인 성공한 경우
        const user = results[0];
        // 토큰 생성 
        // 첫번째 파라미터(페이로드) : 담고싶은 정보(비밀번호와 같은 중요한 데이터는 넣지 말 것)
        // 두번째 파라미터(키) : 위에서 선언한 서버의 비밀 키
        // 세번째 파라미터 : 만료 시간
        const token = jwt.sign({ userId: user.id, name: user.name }, JWT_KEY, { expiresIn: '1h' });
        console.log(token);
        // 토큰 담아서 리턴
        res.json({ success: true, message: "로그인 성공!", token, user: { userId: user.id, name: user.name } });

      } else {
        // 로그인 실패
        res.json({ success: false, message: '실패!' });
      }
    });
  });
router.route("/insert")
  .post((req, res) => {
    const { name, email, pwd, gender } = req.body;
    const query = 'INSERT INTO tbl_user(name, user_id, pwd, gender) VALUES(?, ?, ?, ?)';

    connection.query(query, [name, email, pwd, gender], (err, results) => {
      if (err) {
        return res.json({ success: false, message: "db 오류" });
      };

      res.json({ success: true, meassage: "회원가입 성공!" });
    });
  })

// JWT 인증 미들웨어
const verifyToken = (req, res, next) => {
  const token = req.headers['authorization']?.split(' ')[1]; // Bearer <token>

  if (!token) {
    return res.status(403).json({ success: false, message: '토큰이 필요합니다.' });
  }

  jwt.verify(token, JWT_KEY, (err, decoded) => {
    if (err) {
      return res.status(401).json({ success: false, message: '유효하지 않은 토큰입니다.' });
    }
    req.user = decoded; // 인증된 사용자 정보 저장
    next();
  });
};

// 게시물 조회
router.route("/posts")
  .get(verifyToken, (req, res) => {
    const query = 'SELECT * FROM tbl_post';
    connection.query(query, (err, results) => {
      if (err) {
        console.error('쿼리 실행 실패:', err);
        return res.status(500).json({ success: false, message: '서버 오류' });
      }
      res.json({ success: true, list: results });
    });
  });

// 댓글 추가
router.route("/comments")
  .post(verifyToken, (req, res) => {
    const { postId, content } = req.body;
    const userId = req.user.userId; // JWT에서 사용자 ID 가져오기

    const query = 'INSERT INTO tbl_comment (post_id, user_id, content) VALUES (?, ?, ?)';
    connection.query(query, [postId, userId, content], (err, results) => {
      if (err) {
        console.error('댓글 추가 오류:', err);
        return res.status(500).json({ success: false, message: '댓글 추가 실패' });
      }
      res.json({ success: true, message: '댓글 추가 성공' });
    });
  });
// 사용자 정보 조회 라우트
router.get('/', verifyToken, (req, res) => {
  const userId = req.user.userId; // 토큰에서 가져온 userId
  const query = 'SELECT * FROM tbl_user WHERE id = ?';

  connection.query(query, [userId], (err, results) => {
    if (err) return res.status(500).json({ success: false, message: '서버 오류' });
    if (results.length === 0) return res.status(404).json({ success: false, message: '사용자를 찾을 수 없습니다.' });

    // 필요한 데이터 형식에 맞춰 응답
    const user = results[0];
    res.json({
      success: true, list: {
        name: user.name,
        user_id: user.user_id,
        profileImage: user.profile_image,
        followers: user.followers_count,
        following: user.following_count,
        posts: user.posts_count,
        bio: user.bio
      }
    });
  });
});

// 저장할 디렉토리 및 파일 이름 설정
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
      cb(null, 'uploads/'); // 업로드할 디렉토리
  },
  filename: (req, file, cb) => {
      cb(null, `${Date.now()}-${file.originalname}`); // 파일 이름 설정
  },
});

// multer 미들웨어 설정
const upload = multer({ storage: storage });

// 게시물 등록 라우트 (파일 업로드 처리)
router.post('/register', upload.single('file'), (req, res) => {
  const { user_id, caption } = req.body; // 요청 본문에서 데이터 가져오기
  const image_url = req.file ? req.file.path : null; // 파일 경로 가져오기

  // 입력값 확인
  if (!user_id || !image_url || !caption) {
      return res.status(400).json({ message: '모든 필드를 입력해야 합니다.' });
  }

  // SQL 쿼리 준비
  const sql = 'INSERT INTO tbl_post (user_id, image_url, caption) VALUES (?, ?, ?)';
  const values = [user_id, image_url, caption];

  // 데이터베이스에 게시물 삽입
  connection.query(sql, values, (error, results) => {
      if (error) {
          console.error('게시물 등록 실패:', error);
          return res.status(500).json({ message: '서버 오류' });
      }
      res.status(201).json({ message: '게시물이 등록되었습니다.', postId: results.insertId });
  });
});
module.exports = router;