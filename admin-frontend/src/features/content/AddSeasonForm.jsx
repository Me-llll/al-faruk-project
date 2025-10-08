// src/features/content/AddSeasonForm.jsx
import React from 'react';
import { useForm, Controller } from 'react-hook-form';
import { Box, TextField, Button, Paper, Typography } from '@mui/material';

const AddSeasonForm = ({ onSubmit }) => {
  const { control, handleSubmit, reset } = useForm({
    defaultValues: { seasonTitle: '' },
  });

  const handleFormSubmit = (data) => {
    onSubmit(data.seasonTitle);
    reset(); // Clear the form after submission
  };

  return (
    <Paper component="form" onSubmit={handleSubmit(handleFormSubmit)} sx={{ p: 2, mt: 3 }}>
      <Typography variant="h6" sx={{ mb: 2 }}>Add New Season</Typography>
      <Controller
        name="seasonTitle"
        control={control}
        rules={{ required: 'Season title is required' }}
        render={({ field, fieldState }) => (
          <TextField
            {...field}
            label="Season Title (e.g., Season 1)"
            fullWidth
            error={!!fieldState.error}
            helperText={fieldState.error?.message}
          />
        )}
      />
      <Button type="submit" variant="contained" sx={{ mt: 2 }}>
        Add Season
      </Button>
    </Paper>
  );
};

export default AddSeasonForm;