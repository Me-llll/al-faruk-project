// src/features/reminders/JumuahReminderForm.jsx
import React from 'react';
import { useForm, Controller } from 'react-hook-form';
import { Box, TextField, Button, Paper, Typography, FormControlLabel, Switch } from '@mui/material';
import { TimePicker } from '@mui/x-date-pickers/TimePicker';

const JumuahReminderForm = ({ currentSettings, onSave }) => {
  const { control, handleSubmit, formState: { errors } } = useForm({
    // Use the current settings to populate the form's default values
    defaultValues: {
      enabled: currentSettings.enabled,
      message: currentSettings.message,
      sendTime: currentSettings.sendTime,
    },
  });

  return (
    <Paper component="form" onSubmit={handleSubmit(onSave)} sx={{ p: 3, borderRadius: 2 }}>
      <Typography variant="h6" sx={{ mb: 2 }}>Jumu'ah Reminder Settings</Typography>
      <Typography variant="body2" color="text.secondary" sx={{ mb: 2 }}>
        This reminder will be sent every Friday at the specified time.
      </Typography>

      <Controller
        name="enabled"
        control={control}
        render={({ field }) => (
          <FormControlLabel
            control={<Switch {...field} checked={field.value} />}
            label="Enable Jumu'ah Reminder"
          />
        )}
      />

      <Controller
        name="message"
        control={control}
        rules={{ required: 'A notification message is required.' }}
        render={({ field }) => (
          <TextField
            {...field}
            label="Notification Message"
            fullWidth
            multiline
            rows={4}
            margin="normal"
            error={!!errors.message}
            helperText={errors.message?.message}
          />
        )}
      />

      <Controller
        name="sendTime"
        control={control}
        rules={{ required: 'A send time is required.' }}
        render={({ field }) => (
          <TimePicker
            {...field}
            label="Send Time (every Friday)"
            sx={{ width: '100%', mt: 2 }}
            renderInput={(params) => <TextField {...params} error={!!errors.sendTime} helperText={errors.sendTime?.message} />}
          />
        )}
      />

      <Button type="submit" variant="contained" color="secondary" sx={{ mt: 3 }}>
        Save Changes
      </Button>
    </Paper>
  );
};

export default JumuahReminderForm;