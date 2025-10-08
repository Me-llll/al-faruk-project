// src/features/content/ContentLayout.jsx
import React from 'react';
import { Outlet, useLocation, Link as RouterLink } from 'react-router-dom';
import { Box, Tabs, Tab } from '@mui/material';
import PageHeader from '../../components/PageHeader';

const ContentLayout = () => {
  const location = useLocation();

  return (
    <Box>
      <PageHeader
        title="Content Management"
        subtitle="Manage movies, series, and audio content available in the application."
      />
      <Box sx={{ borderBottom: 1, borderColor: 'divider', mb: 3 }}>
        <Tabs value={location.pathname}>
          <Tab
            label="Movies"
            value="/content/movies"
            component={RouterLink}
            to="/content/movies"
          />
          <Tab
            label="Series"
            value="/content/series"
            component={RouterLink}
            to="/content/series"
          />
          {/* Add the new Audio tab */}
          <Tab
            label="Audio"
            value="/content/audio"
            component={RouterLink}
            to="/content/audio"
          />
        </Tabs>
      </Box>

      <Outlet />
    </Box>
  );
};

export default ContentLayout;