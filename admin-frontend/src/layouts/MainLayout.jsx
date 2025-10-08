// src/layouts/MainLayout.jsx
import React, { useState } from 'react';
import { Outlet } from 'react-router-dom';
import { Box, Toolbar } from '@mui/material';
import Sidebar from './Sidebar';
import Header from './Header';

const drawerWidth = 240;

const MainLayout = () => {
  // State to manage the mobile drawer's open/closed status
  const [mobileOpen, setMobileOpen] = useState(false);

  // Function to toggle the mobile drawer
  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  return (
    <Box sx={{ display: 'flex' }}>
      {/* Pass the toggle function to the Header */}
      <Header drawerWidth={drawerWidth} handleDrawerToggle={handleDrawerToggle} />
      
      {/* Pass state and toggle function to the Sidebar */}
      <Sidebar
        drawerWidth={drawerWidth}
        mobileOpen={mobileOpen}
        handleDrawerToggle={handleDrawerToggle}
      />

      <Box
        component="main"
        sx={{
          flexGrow: 1,
          p: 3,
          width: { sm: `calc(100% - ${drawerWidth}px)` }, // Ensure content width is correct on larger screens
        }}
      >
        <Toolbar /> {/* Spacer for the header */}
        <Outlet /> {/* Your page content will be rendered here */}
      </Box>
    </Box>
  );
};

export default MainLayout;