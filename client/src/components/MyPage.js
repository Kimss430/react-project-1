import React, { useEffect, useState } from 'react';
import { Container, Typography, Box, Avatar, Grid, Paper } from '@mui/material';
import axios from 'axios';

function MyPage() {
  const [userData, setUserData] = useState(null);

  // 사용자 데이터 가져오기 함수
  async function fnList() {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        console.log("사용자 토큰이 없습니다.");
        return;
      }

      const res = await axios.get('http://localhost:3100/user', {
        headers: { Authorization: `Bearer ${token}` }  // 토큰을 헤더에 추가
      });

      if (res.data.success) {
        const user = Array.isArray(res.data.list) ? res.data.list[0] : res.data.list; // 배열인지 객체인지 체크
        setUserData({
          name: user.name,
          username: user.user_id,
          profileImage: user.profileImage || 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
          followers: user.followers || 150,
          following: user.following || 100,
          posts: user.posts || 50,
          bio: user.bio || '안녕하세요! SNS를 통해 친구들과 소통하고 있습니다. 사진과 일상을 공유하는 것을 좋아해요.',
        });
      } else {
        console.log("에러: 사용자 데이터를 불러올 수 없습니다.");
      }
    } catch (err) {
      console.log("에러 발생:", err);
    }
  }

  useEffect(() => {
    fnList();
  }, []);

  if (!userData) {
    return <Typography>사용자 정보를 불러오는 중...</Typography>;
  }

  return (
    <Container maxWidth="md">
      <Box
        display="flex"
        flexDirection="column"
        alignItems="center"
        justifyContent="flex-start"
        minHeight="100vh"
        sx={{ padding: '20px' }}
      >
        <Paper elevation={3} sx={{ padding: '20px', borderRadius: '15px', width: '100%' }}>
          {/* 프로필 정보 상단 배치 */}
          <Box display="flex" flexDirection="column" alignItems="center" sx={{ marginBottom: 3 }}>
            <Avatar
              alt="프로필 이미지"
              src={userData.profileImage}
              sx={{ width: 100, height: 100, marginBottom: 2 }}
            />
            <Typography variant="h5">{userData.name}</Typography>
            <Typography variant="body2" color="text.secondary">
              @{userData.username}
            </Typography>
          </Box>
          <Grid container spacing={2} sx={{ marginTop: 2 }}>
            <Grid item xs={4} textAlign="center">
              <Typography variant="h6">팔로워</Typography>
              <Typography variant="body1">{userData.followers}</Typography>
            </Grid>
            <Grid item xs={4} textAlign="center">
              <Typography variant="h6">팔로잉</Typography>
              <Typography variant="body1">{userData.following}</Typography>
            </Grid>
            <Grid item xs={4} textAlign="center">
              <Typography variant="h6">게시물</Typography>
              <Typography variant="body1">{userData.posts}</Typography>
            </Grid>
          </Grid>
          <Box sx={{ marginTop: 3 }}>
            <Typography variant="h6">내 소개</Typography>
            <Typography variant="body1">{userData.bio}</Typography>
          </Box>
        </Paper>
      </Box>
    </Container>
  );
}

export default MyPage;
