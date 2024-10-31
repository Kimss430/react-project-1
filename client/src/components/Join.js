import React, { useRef } from 'react';
import { Box, Button, TextField, Typography } from '@mui/material';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormControl from '@mui/material/FormControl';
import FormLabel from '@mui/material/FormLabel';


function Join() {
  const nameRef = useRef();
  const emailRef = useRef();
  const pwdRef = useRef();
  const confirmPwdRef = useRef();
  const genderRef = useRef();
  const navigate = useNavigate();

  async function fnJoin() {
    const name = nameRef.current.value;
    const email = emailRef.current.value;
    const pwd = pwdRef.current.value;
    const gender = genderRef.current.value;
    const confirmPwd = confirmPwdRef.current.value;
    if (pwd != confirmPwd) {
      alert("비밀번호 다름");
      return;
    }
    try {
      const res = await axios.post("http://localhost:3100/user/insert", {
        name, email, pwd, gender
      }); // {email : eamil, pwd : pwd}

      if (res.data.success) {
        alert("회원가입 되었습니다.")
        navigate("/login");
      } else {
        alert("이메일 중복");
      }


    } catch (error) {
      console.log("서버 호출 중 오류 발생");
    }
  }

  return (
    <Box
      display="flex"
      flexDirection="column"
      alignItems="center"
      justifyContent="center"
      height="100vh"
      sx={{ backgroundColor: '#e0f7fa', padding: 3 }}
    >
      <Box
        sx={{
          width: '100%',
          maxWidth: '400px',
          padding: '20px',
          backgroundColor: '#fff',
          boxShadow: '0px 4px 10px rgba(0, 0, 0, 0.1)',
          borderRadius: '8px'
        }}
      >
        <Typography variant="h4" mb={3} align="center">
          회원가입
        </Typography>
        <TextField inputRef={nameRef} label="이름" variant="outlined" margin="normal" fullWidth />
        <TextField inputRef={emailRef} label="이메일" variant="outlined" fullWidth margin="normal" />
        <TextField inputRef={pwdRef} label="비밀번호" variant="outlined" type="password" fullWidth margin="normal" />
        <TextField inputRef={confirmPwdRef} label="비밀번호 확인" variant="outlined" type="password" fullWidth margin="normal" />
        <FormControl>
          <FormLabel id="demo-row-radio-buttons-group-label">성별</FormLabel>
          <RadioGroup
            row
            aria-labelledby="demo-row-radio-buttons-group-label"
            name="row-radio-buttons-group"
          >
            <FormControlLabel inputRef={genderRef} value="M" control={<Radio />} label="남자" />
            <FormControlLabel inputRef={genderRef} value="F" control={<Radio />} label="여자" />
          </RadioGroup>
        </FormControl>
        <Button onClick={fnJoin} variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          회원가입
        </Button>
        <Typography mt={2} align="center">
          이미 계정이 있으신가요? <a href="/login">로그인</a>
        </Typography>
      </Box>
    </Box>
  );
};

export default Join;
