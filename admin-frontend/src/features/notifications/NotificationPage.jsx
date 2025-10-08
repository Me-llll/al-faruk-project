// src/features/notifications/NotificationPage.jsx
import React, { useState } from 'react';
import { useForm, Controller } from 'react-hook-form';
import { Box, TextField, Button, Paper, Typography, Grid } from '@mui/material';
import { DataGrid } from '@mui/x-data-grid';
import PageHeader from '../../components/PageHeader';
import { mockNotifications } from './mockNotificationData'; // Import mock data

const NotificationPage = () => {
  // State to manage the list of notifications
  const [notifications, setNotifications] = useState(mockNotifications);

  // Setup for react-hook-form
  const { control, handleSubmit, reset, formState: { errors } } = useForm({
    defaultValues: { title: '', message: '' },
  });

  // Function to handle form submission
  const onSubmit = (data) => {
    console.log('Sending notification:', data);

    // Create a new notification object
    const newNotification = {
      id: notifications.length + 1, // Simple ID generation
      title: data.title,
      message: data.message,
      sentDate: new Date().toISOString(), // Use current date
    };

    // Add the new notification to the top of the list
    setNotifications([newNotification, ...notifications]);

    // Reset the form fields
    reset();
  };

  // Define columns for the DataGrid history table
  const columns = [
    { field: 'id', headerName: 'ID', width: 90 },
    { field: 'title', headerName: 'Title', width: 250 },
    { field: 'message', headerName: 'Message', flex: 1 }, // flex: 1 allows this column to grow
    {
      field: 'sentDate',
      headerName: 'Date Sent',
      width: 200,
      // Format the date to be more readable
      valueFormatter: (params) => new Date(params.value).toLocaleString(),
    },
  ];

  return (
    <Box>
      <PageHeader
        title="Send Notification"
        subtitle="Create and push a new notification to all application users."
      />
      <Grid container spacing={4}>
        {/* Left side: The Form */}
        <Grid item xs={12} md={4}>
          <Paper component="form" onSubmit={handleSubmit(onSubmit)} sx={{ p: 3 }}>
            <Typography variant="h6" sx={{ mb: 2 }}>Create Notification</Typography>
            <Controller
              name="title"
              control={control}
              rules={{ required: 'Title is required' }}
              render={({ field }) => (
                <TextField
                  {...field}
                  label="Notification Title"
                  fullWidth
                  margin="normal"
                  error={!!errors.title}
                  helperText={errors.title?.message}
                />
              )}
            />
            <Controller
              name="message"
              control={control}
              rules={{ required: 'Message is required' }}
              render={({ field }) => (
                <TextField
                  {...field}
                  label="Notification Message"
                  fullWidth
                  multiline
                  rows={5}
                  margin="normal"
                  error={!!errors.message}
                  helperText={errors.message?.message}
                />
              )}
            />
            <Button type="submit" variant="contained" color="secondary" sx={{ mt: 2 }}>
              Send Notification
            </Button>
          </Paper>
        </Grid>

        {/* Right side: The History Table */}
        <Grid item xs={12} md={8}>
          <Paper sx={{ p: 3, height: '70vh' }}>
             <Typography variant="h6" sx={{ mb: 2 }}>Notification History</Typography>
            <DataGrid
              rows={notifications}
              columns={columns}
              pageSize={10}
              rowsPerPageOptions={[10]}
              disableSelectionOnClick
              sx={{ border: 0 }}
            />
          </Paper>
        </Grid>
      </Grid>
    </Box>
  );
};

export default NotificationPage;