// src/components/PageHeader.jsx
import { Typography } from '@mui/material';

const PageHeader = ({ title, subtitle }) => {
  return (
    <>
      <Typography variant="h4" component="h1" gutterBottom>
        {title}
      </Typography>
      {subtitle && (
        <Typography variant="subtitle1" color="text.secondary" sx={{ mb: 3 }}>
          {subtitle}
        </Typography>
      )}
    </>
  );
};

export default PageHeader;