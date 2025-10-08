// src/layouts/Header.jsx
import React from 'react';
import { AppBar, Toolbar, IconButton, Box } from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu';
import { useThemeContext } from '../contexts/ThemeContext';
import { useAuth } from '../contexts/AuthContext';
import Brightness4Icon from '@mui/icons-material/Brightness4';
import Brightness7Icon from '@mui/icons-material/Brightness7';
import PersonIcon from '@mui/icons-material/Person';
import LogoutIcon from '@mui/icons-material/Logout';

const Header = ({ drawerWidth, handleDrawerToggle }) => {
  const { mode, toggleColorMode } = useThemeContext();
  const { logout } = useAuth();

  return (
    <AppBar
      position="fixed"
      // NEW: Set the background color to match the sidebar's "paper" color.
      // The color will be white in light mode and dark grey in dark mode automatically.
      color="default"
      // The elevation prop is removed as we handle shadows globally now.
      sx={{
        width: { sm: `calc(100% - ${drawerWidth}px)` },
        ml: { sm: `${drawerWidth}px` },
        // NEW: Set the background explicitly for consistency.
        backgroundColor: 'background.paper',
        // Use the new theme divider color for a subtle border.
        borderBottom: '1px solid',
        borderColor: 'divider',
      }}
    >
      <Toolbar>
        {/* Hamburger Icon for mobile */}
        <IconButton
          color="inherit"
          aria-label="open drawer"
          edge="start"
          onClick={handleDrawerToggle}
          sx={{ mr: 2, display: { sm: 'none' } }}
        >
          <MenuIcon />
        </IconButton>
        
        {/* This Box pushes the other icons to the right */}
        <Box sx={{ flexGrow: 1 }} />
        
        <IconButton sx={{ ml: 1 }} onClick={toggleColorMode} color="inherit">
          {mode === 'dark' ? <Brightness7Icon /> : <Brightness4Icon />}
        </IconButton>
        <IconButton color="inherit">
          <PersonIcon />
        </IconButton>
        <IconButton color="inherit" onClick={logout}>
          <LogoutIcon />
        </IconButton>
      </Toolbar>
    </AppBar>
  );
};

export default Header;