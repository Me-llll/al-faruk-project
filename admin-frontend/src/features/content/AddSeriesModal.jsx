// src/features/content/AddSeriesModal.jsx
import React from 'react';
import { useForm, Controller } from 'react-hook-form';
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  TextField,
  Box,
  Typography
} from '@mui/material';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';

const VisuallyHiddenInput = styled('input')({
  clip: 'rect(0 0 0 0)', clipPath: 'inset(50%)', height: 1,
  overflow: 'hidden', position: 'absolute', bottom: 0, left: 0,
  whiteSpace: 'nowrap', width: 1,
});


const AddSeriesModal = ({ open, onClose, onSubmit }) => {
  const { control, handleSubmit, formState: { errors } } = useForm({
    defaultValues: {
      title: '',
      description: '',
      posterFile: null,
    },
  });

  // We wrap the parent's onSubmit to include form data
  const handleFormSubmit = (data) => {
    onSubmit(data);
    onClose(); // Close the modal after submission
  };

  return (
    <Dialog open={open} onClose={onClose} fullWidth maxWidth="sm">
      <form onSubmit={handleSubmit(handleFormSubmit)}>
        <DialogTitle>Add a New Series</DialogTitle>
        <DialogContent>
          {/* Title Field */}
          <Controller
            name="title"
            control={control}
            rules={{ required: 'Title is required' }}
            render={({ field }) => (
              <TextField
                {...field}
                autoFocus
                margin="dense"
                label="Series Title"
                type="text"
                fullWidth
                variant="outlined"
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
                margin="dense"
                label="Series Description"
                type="text"
                fullWidth
                multiline
                rows={4}
                variant="outlined"
                error={!!errors.description}
                helperText={errors.description?.message}
              />
            )}
          />

          {/* Poster Upload */}
          <Box sx={{ mt: 2 }}>
            <Button
              component="label"
              variant="outlined"
              startIcon={<CloudUploadIcon />}
            >
              Upload Poster
              <Controller
                name="posterFile"
                control={control}
                render={({ field }) => (
                  <VisuallyHiddenInput type="file" onChange={(e) => field.onChange(e.target.files[0])} />
                )}
              />
            </Button>
            <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
              A poster image is recommended.
            </Typography>
          </Box>

        </DialogContent>
        <DialogActions>
          <Button onClick={onClose}>Cancel</Button>
          <Button type="submit" variant="contained">Add Series</Button>
        </DialogActions>
      </form>
    </Dialog>
  );
};

export default AddSeriesModal;