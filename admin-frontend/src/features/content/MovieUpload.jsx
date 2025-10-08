// src/features/content/MovieUpload.jsx
import React from 'react';
import { useForm, Controller } from 'react-hook-form';
import { Box, TextField, Button, Paper } from '@mui/material';
import PageHeader from '../../components/PageHeader';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';

// A small styled component for our file input
const VisuallyHiddenInput = styled('input')({
  clip: 'rect(0 0 0 0)',
  clipPath: 'inset(50%)',
  height: 1,
  overflow: 'hidden',
  position: 'absolute',
  bottom: 0,
  left: 0,
  whiteSpace: 'nowrap',
  width: 1,
});

const MovieUpload = () => {
  // Initialize react-hook-form
  const { control, handleSubmit, formState: { errors } } = useForm({
    defaultValues: {
      title: '',
      description: '',
      trailerFile: null,
      movieFile: null,
    },
  });

  // This function will be called on successful form submission
  const onSubmit = (data) => {
    console.log('Form data submitted:', data);
    // In a real app, you would use FormData to send this to your API
    alert(`Submitting Movie: ${data.title}`);
  };

  return (
    <Paper component="form" onSubmit={handleSubmit(onSubmit)} sx={{ p: 3 }}>
      <PageHeader
        title="Upload New Movie"
        subtitle="Fill in the details below to add a new movie to the catalog."
      />

      {/* Title Field */}
      <Controller
        name="title"
        control={control}
        rules={{ required: 'Title is required' }}
        render={({ field }) => (
          <TextField
            {...field}
            label="Movie Title"
            variant="outlined"
            fullWidth
            margin="normal"
            error={!!errors.title}
            helperText={errors.title?.message}
          />
        )}
      />

      {/* Description Field */}
      <Controller
        name="description"
        control={control}
        rules={{ required: 'Description is required' }}
        render={({ field }) => (
          <TextField
            {...field}
            label="Description"
            variant="outlined"
            fullWidth
            multiline
            rows={4}
            margin="normal"
            error={!!errors.description}
            helperText={errors.description?.message}
          />
        )}
      />

      <Box sx={{ display: 'flex', gap: 2, my: 2 }}>
        {/* Trailer Upload Button */}
        <Button
          component="label"
          variant="outlined"
          startIcon={<CloudUploadIcon />}
        >
          Upload Trailer (Optional)
          <Controller
            name="trailerFile"
            control={control}
            render={({ field }) => (
              <VisuallyHiddenInput type="file" onChange={(e) => field.onChange(e.target.files[0])} />
            )}
          />
        </Button>

        {/* Movie Upload Button */}
        <Button
          component="label"
          variant="contained"
          startIcon={<CloudUploadIcon />}
        >
          Upload Movie*
          <Controller
            name="movieFile"
            control={control}
            rules={{ required: 'Movie file is required' }}
            render={({ field }) => (
              <VisuallyHiddenInput type="file" onChange={(e) => field.onChange(e.target.files[0])} />
            )}
          />
        </Button>
      </Box>
       {errors.movieFile && <Typography color="error" variant="body2">{errors.movieFile.message}</Typography>}


      {/* Submit Button */}
      <Box sx={{ mt: 3 }}>
        <Button type="submit" variant="contained" color="secondary" size="large">
          Submit Movie
        </Button>
      </Box>
    </Paper>
  );
};

export default MovieUpload;