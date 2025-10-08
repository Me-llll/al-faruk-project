// src/features/content/EpisodeManager.jsx
import React from 'react';
import { useForm, Controller } from 'react-hook-form';
import { Box, TextField, Button, Typography, Paper, List, ListItem, ListItemText } from '@mui/material';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';

const VisuallyHiddenInput = styled('input')({ /* ... same as before ... */ });

const EpisodeManager = ({ selectedSeason, onEpisodeSubmit }) => {
  const { control, handleSubmit, reset, formState: { errors } } = useForm({
    defaultValues: { episodeTitle: '', episodeFile: null },
  });

  if (!selectedSeason) {
    return (
      <Paper sx={{ p: 3, mt: 3, textAlign: 'center' }}>
        <Typography color="text.secondary">Select a season to manage episodes.</Typography>
      </Paper>
    );
  }

  const handleFormSubmit = (data) => {
    onEpisodeSubmit(selectedSeason.id, data);
    reset();
  };

  return (
    <Paper sx={{ p: 3, mt: 3 }}>
      <Typography variant="h6">Episodes for {selectedSeason.title}</Typography>
      <List>
        {selectedSeason.episodes.map(ep => (
          <ListItem key={ep.id} divider>
            <ListItemText primary={ep.title} />
          </ListItem>
        ))}
        {selectedSeason.episodes.length === 0 && <ListItem><ListItemText primary="No episodes uploaded yet." /></ListItem>}
      </List>

      <Box component="form" onSubmit={handleSubmit(handleFormSubmit)} sx={{ mt: 3 }}>
        <Typography variant="subtitle1" sx={{ mb: 2 }}>Upload New Episode</Typography>
        <Controller name="episodeTitle" control={control} rules={{ required: true }} render={({ field }) => <TextField {...field} label="Episode Title" fullWidth margin="normal" error={!!errors.episodeTitle} />} />
        <Button component="label" variant="outlined" startIcon={<CloudUploadIcon />} sx={{ mt: 1 }}>
          Upload Episode Video
          <Controller name="episodeFile" control={control} rules={{ required: true }} render={({ field }) => <VisuallyHiddenInput type="file" onChange={(e) => field.onChange(e.target.files[0])} />} />
        </Button>
         {errors.episodeFile && <Typography color="error" variant="body2" sx={{ mt: 1 }}>An episode file is required.</Typography>}
        <Button type="submit" variant="contained" sx={{ display: 'block', mt: 2 }}>Add Episode</Button>
      </Box>
    </Paper>
  );
};

export default EpisodeManager;