// src/features/content/AudioUpload.jsx
import React from 'react';
import { useForm, Controller } from 'react-hook-form';
import { Box, TextField, Button, Paper, Typography } from '@mui/material';
import PageHeader from '../../components/PageHeader';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';

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

const AudioUpload = () => {
  const { control, handleSubmit, formState: { errors } } = useForm({
    defaultValues: {
      title: '',
      description: '',
      coverArtFile: null,
      audioFile: null,
    },
  });

  const onSubmit = (data) => {
    console.log('Audio Form data submitted:', data);
    alert(`Submitting Audio: ${data.title}`);
  };

  return (
    <Paper component="form" onSubmit={handleSubmit(onSubmit)} sx={{ p: 3, borderRadius: 2 }}>
      <PageHeader
        title="Upload New Audio"
        subtitle="Fill in the details below to add a new audio track or podcast."
      />

      <Controller
        name="title"
        control={control}
        rules={{ required: 'Title is required' }}
        render={({ field }) => (
          <TextField
            {...field}
            label="Audio Title"
            variant="outlined"
            fullWidth
            margin="normal"
            error={!!errors.title}
            helperText={errors.title?.message}
          />
        )}
      />

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
        <Button
          component="label"
          variant="outlined"
          startIcon={<CloudUploadIcon />}
        >
          Upload Cover Art (Optional)
          <Controller
            name="coverArtFile"
            control={control}
            render={({ field }) => (
              <VisuallyHiddenInput type="file" accept="image/*" onChange={(e) => field.onChange(e.target.files[0])} />
            )}
          />
        </Button>

        <Button
          component="label"
          variant="contained"
          startIcon={<CloudUploadIcon />}
        >
          Upload Audio File*
          <Controller
            name="audioFile"
            control={control}
            rules={{ required: 'An audio file is required' }}
            render={({ field }) => (
              <VisuallyHiddenInput type="file" accept="audio/*" onChange={(e) => field.onChange(e.target.files[0])} />
            )}
          />
        </Button>
      </Box>
      {errors.audioFile && <Typography color="error" variant="body2">{errors.audioFile.message}</Typography>}

      <Box sx={{ mt: 3 }}>
        <Button type="submit" variant="contained" color="secondary" size="large">
          Submit Audio
        </Button>
      </Box>
    </Paper>
  );
};

export default AudioUpload;