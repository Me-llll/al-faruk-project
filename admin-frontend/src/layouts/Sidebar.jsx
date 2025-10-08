// src/layouts/Sidebar.jsx
import React, { useState } from 'react';
import { NavLink } from 'react-router-dom';
import { Box, Collapse, Drawer, List, ListItem, ListItemButton, ListItemIcon, ListItemText, Toolbar, Typography } from '@mui/material';
import DashboardIcon from '@mui/icons-material/Dashboard';
import VideoLibraryIcon from '@mui/icons-material/VideoLibrary';
import NotificationsIcon from '@mui/icons-material/Notifications';
import AccessAlarmIcon from '@mui/icons-material/AccessAlarm';
import PeopleIcon from '@mui/icons-material/People';
import MovieIcon from '@mui/icons-material/Movie';
import TheatersIcon from '@mui/icons-material/Theaters';
import AudiotrackIcon from '@mui/icons-material/Audiotrack';
import ExpandLess from '@mui/icons-material/ExpandLess';
import ExpandMore from '@mui/icons-material/ExpandMore';
import Logo from '../assets/logo.png';

const sidebarItems = [
  { text: 'Dashboard', icon: <DashboardIcon />, path: '/dashboard' },
  {
    text: 'Content Upload',
    icon: <VideoLibraryIcon />,
    path: '/content',
    children: [
      { text: 'Movies', icon: <MovieIcon />, path: '/content/movies' },
      { text: 'Series', icon: <TheatersIcon />, path: '/content/series' },
      { text: 'Audio', icon: <AudiotrackIcon />, path: '/content/audio' },
    ],
  },
  { text: 'Notification', icon: <NotificationsIcon />, path: '/notifications' },
  { text: 'Reminder Setup', icon: <AccessAlarmIcon />, path: '/reminders' },
  { text: 'User List', icon: <PeopleIcon />, path: '/users' },
];

const Sidebar = ({ drawerWidth, mobileOpen, handleDrawerToggle }) => {
  const [contentOpen, setContentOpen] = useState(true);

  const handleContentClick = () => {
    setContentOpen(!contentOpen);
  };

  const drawerContent = (
    <Box sx={{ borderRight: '1px solid', borderColor: 'divider' }}>
      <Toolbar sx={{ px: 2, display: 'flex', alignItems: 'center', justifyContent: 'flex-start' }}>
        <img src={Logo} alt="Al Faruk Logo" style={{ height: 32, marginRight: 12 }} />
        <Typography variant="h6" noWrap fontWeight="bold">Al Faruk</Typography>
      </Toolbar>
      <Box sx={{ overflow: 'auto', px: 2 }}>
        <List>
          {sidebarItems.map((item) => {
            if (item.children) {
              return (
                <React.Fragment key={item.text}>
                  <ListItemButton onClick={handleContentClick} sx={{ borderRadius: 1 }}>
                    <ListItemIcon sx={{ minWidth: 40 }}>{item.icon}</ListItemIcon>
                    <ListItemText primary={item.text} />
                    {contentOpen ? <ExpandLess /> : <ExpandMore />}
                  </ListItemButton>
                  <Collapse in={contentOpen} timeout="auto" unmountOnExit>
                    <List component="div" disablePadding>
                      {item.children.map((child) => (
                        <ListItem key={child.text} disablePadding>
                          <ListItemButton
                            component={NavLink}
                            to={child.path}
                            sx={{
                              pl: 4,
                              borderRadius: 1,
                              '&.active': {
                                backgroundColor: (theme) => `${theme.palette.secondary.main} !important`,
                                color: 'primary.main',
                                fontWeight: 'fontWeightBold',
                                '& .MuiListItemIcon-root': {
                                  color: 'primary.main',
                                },
                              },
                            }}
                          >
                            <ListItemIcon sx={{ minWidth: 40 }}>{child.icon}</ListItemIcon>
                            <ListItemText primary={child.text} />
                          </ListItemButton>
                        </ListItem>
                      ))}
                    </List>
                  </Collapse>
                </React.Fragment>
              );
            }
            return (
              <ListItem key={item.text} disablePadding>
                <ListItemButton
                  component={NavLink}
                  to={item.path}
                  sx={{
                    borderRadius: 1,
                    '&.active': {
                      backgroundColor: (theme) => `${theme.palette.secondary.main} !important`,
                      color: 'primary.main',
                      fontWeight: 'fontWeightBold',
                      '& .MuiListItemIcon-root': {
                        color: 'primary.main',
                      },
                    },
                  }}
                >
                  <ListItemIcon sx={{ minWidth: 40 }}>{item.icon}</ListItemIcon>
                  <ListItemText primary={item.text} />
                </ListItemButton>
              </ListItem>
            );
          })}
        </List>
      </Box>
    </Box>
  );

  return (
    <Box component="nav" sx={{ width: { sm: drawerWidth }, flexShrink: { sm: 0 } }}>
      <Drawer
        variant="temporary"
        open={mobileOpen}
        onClose={handleDrawerToggle}
        ModalProps={{ keepMounted: true }}
        sx={{
          display: { xs: 'block', sm: 'none' },
          '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth, borderRight: 'none' },
        }}
      >
        {drawerContent}
      </Drawer>
      <Drawer
        variant="permanent"
        sx={{
          display: { xs: 'none', sm: 'block' },
          '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth, borderRight: 'none' },
        }}
        open
      >
        {drawerContent}
      </Drawer>
    </Box>
  );
};

export default Sidebar;