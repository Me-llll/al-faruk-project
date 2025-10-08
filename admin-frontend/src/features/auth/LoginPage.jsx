// src/features/auth/LoginPage.jsx

import React from 'react';
import { useNavigate } from 'react-router-dom';      // Import useNavigate for redirection
import { useAuth } from '../../contexts/AuthContext'; // Import our custom auth hook
import { Box, Button, Paper, TextField, Typography } from '@mui/material';
import Logo from '../../assets/logo.png';

const LoginPage = () => {
  // Set up the hooks we need
  const navigate = useNavigate();
  const { login } = useAuth();

  // This function will be called when the form is submitted
  const handleLogin = (event) => {
    event.preventDefault(); // Prevent the browser from refreshing the page
    
    // In a real application, you would send the email and password
    // from the form to your backend API to verify them.
    // For now, we just call our simulated login function.
    login();

    // After successfully "logging in", redirect the user to the dashboard.
    navigate('/dashboard');
  };

  return (
    <Box
      sx={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh',
        backgroundColor: 'background.default',
      }}
    >
      <Paper
        component="form"
        onSubmit={handleLogin} // The handleLogin function is now connected to the form
        sx={{
          padding: 4,
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          width: { xs: '90%', sm: 400 }, // Responsive width
        }}
      >
        <img src={Logo} alt="Al Faruk Logo" style={{ height: 60, marginBottom: 2 }} />
        <Typography component="h1" variant="h5" sx={{ mb: 3 }}>
          Admin Panel Login
        </Typography>
        <TextField
          margin="normal"
          required
          fullWidth
          id="email"
          label="Email Address"
          name="email"
          autoComplete="email"
          autoFocus
        />
        <TextField
          margin="normal"
          required
          fullWidth
          name="password"
          label="Password"
          type="password"
          id="password"
          autoComplete="current-password"
        />
        <Button
          type="submit"
          fullWidth
          variant="contained"
          color="secondary"
          sx={{ mt: 3, mb: 2, color: 'primary.main', fontWeight: 'bold' }}
        >
          Sign In
        </Button>
      </Paper>
    </Box>
  );
};

export default LoginPage;