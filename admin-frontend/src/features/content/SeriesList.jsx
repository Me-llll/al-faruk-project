// src/features/content/SeriesList.jsx
import React, { useState } from 'react';
import { Box, Button, Typography, Paper, List, ListItem, ListItemText, IconButton } from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete'; // 1. Import the Delete Icon
import { Link as RouterLink } from 'react-router-dom';
import AddSeriesModal from './AddSeriesModal';

const initialSeries = [
  { id: 1, title: 'Epic Adventures', seasons: 3 },
  { id: 2, title: 'Cybernetic Dreams', seasons: 1 },
  { id: 3, title: 'The Lost Kingdom', seasons: 5 },
];

const SeriesList = () => {
  const [seriesList, setSeriesList] = useState(initialSeries);
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleOpenModal = () => setIsModalOpen(true);
  const handleCloseModal = () => setIsModalOpen(false);

  const handleAddSeries = (formData) => {
    console.log('New Series Data:', formData);
    const newSeries = {
      id: seriesList.length + 5, // Use a bigger number to avoid ID conflicts
      title: formData.title,
      seasons: 0,
    };
    setSeriesList([...seriesList, newSeries]);
  };

  // 2. Add the function to handle deleting a series
  const handleDeleteSeries = (seriesIdToDelete) => {
    // Show a confirmation dialog to prevent accidental deletion
    if (window.confirm('Are you sure you want to delete this series? This action cannot be undone.')) {
      // Filter out the series with the matching ID
      setSeriesList(currentList => currentList.filter(series => series.id !== seriesIdToDelete));
    }
  };

  return (
    <>
      <Paper sx={{ p: 3 }}>
        <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
          <Typography variant="h6">Existing Series</Typography>
          <Button variant="contained" startIcon={<AddIcon />} onClick={handleOpenModal}>
            Add New Series
          </Button>
        </Box>
        <List>
          {seriesList.map((series) => (
            <ListItem
              key={series.id}
              divider
              secondaryAction={
                <>
                  <IconButton
                    edge="end"
                    aria-label="edit"
                    onClick={(e) => {
                      e.preventDefault();
                      alert(`Edit series: ${series.title}`);
                    }}
                    sx={{ mr: 1 }} // Add margin to separate icons
                  >
                    <EditIcon />
                  </IconButton>
                  {/* 3. Add the Delete Icon Button */}
                  <IconButton
                    edge="end"
                    aria-label="delete"
                    color="error" // Use error color for destructive actions
                    onClick={(e) => {
                      e.preventDefault(); // IMPORTANT: Prevents navigating when clicking delete
                      handleDeleteSeries(series.id);
                    }}
                  >
                    <DeleteIcon />
                  </IconButton>
                </>
              }
            >
              {/* The ListItemText is wrapped in a link to allow navigation */}
              <RouterLink
                to={`/content/series/${series.id}`}
                style={{ textDecoration: 'none', color: 'inherit', display: 'block' }}
              >
                <ListItemText
                  primary={series.title}
                  secondary={`${series.seasons} Season(s)`}
                />
              </RouterLink>
            </ListItem>
          ))}
        </List>
      </Paper>

      <AddSeriesModal open={isModalOpen} onClose={handleCloseModal} onSubmit={handleAddSeries} />
    </>
  );
};

export default SeriesList;