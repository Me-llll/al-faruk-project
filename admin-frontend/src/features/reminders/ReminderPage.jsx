// src/features/reminders/ReminderPage.jsx
import React, { useState } from 'react';
import { Box, Tabs, Tab } from '@mui/material';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import PageHeader from '../../components/PageHeader';
import JumuahReminderForm from './JumuahReminderForm';
import KhamisReminderForm from './KhamisReminderForm';
import dayjs from 'dayjs'; // Import dayjs to create date objects

// Mock initial settings fetched from a database
const initialJumuahSettings = {
  enabled: true,
  message: 'Don\'t forget to read Surah Al-Kahf. Jumu\'ah Mubarak!',
  sendTime: dayjs('2022-04-17T12:00'), // We only care about the time part
};

const initialKhamisSettings = {
  enabled: true,
  message: 'Don\'t forget to send Salawat upon the Prophet (ﷺ).',
  hadith: 'The Messenger of Allah (ﷺ) said: "The best of your days is Friday. So send a great deal of salah upon me on that day, for your salah will be presented to me."',
  sendTime: dayjs('2022-04-17T18:30'), // We only care about the time part
};

const ReminderPage = () => {
  const [activeTab, setActiveTab] = useState(0);
  
  // State to hold the settings for each reminder
  const [jumuahSettings, setJumuahSettings] = useState(initialJumuahSettings);
  const [khamisSettings, setKhamisSettings] = useState(initialKhamisSettings);

  const handleTabChange = (event, newValue) => {
    setActiveTab(newValue);
  };

  // Handlers to update the settings
  const handleSaveJumuah = (data) => {
    console.log('Saving Jumu\'ah Settings:', data);
    setJumuahSettings(data);
    alert('Jumu\'ah reminder settings have been saved!');
  };

  const handleSaveKhamis = (data) => {
    console.log('Saving Khamis Settings:', data);
    setKhamisSettings(data);
    alert('Khamis Salawat reminder settings have been saved!');
  };

  return (
    <LocalizationProvider dateAdapter={AdapterDayjs}>
      <Box>
        <PageHeader
          title="Recurring Reminders"
          subtitle="Configure the automated Jumu'ah and Khamis Salawat reminders."
        />
        <Box sx={{ borderBottom: 1, borderColor: 'divider', mb: 3 }}>
          <Tabs value={activeTab} onChange={handleTabChange} aria-label="reminder types tabs">
            <Tab label="Jumu'ah Reminder" />
            <Tab label="Khamis Salawat Reminder" />
          </Tabs>
        </Box>

        {/* Conditionally render the correct form based on the active tab */}
        <Box hidden={activeTab !== 0}>
          <JumuahReminderForm currentSettings={jumuahSettings} onSave={handleSaveJumuah} />
        </Box>
        <Box hidden={activeTab !== 1}>
          <KhamisReminderForm currentSettings={khamisSettings} onSave={handleSaveKhamis} />
        </Box>
      </Box>
    </LocalizationProvider>
  );
};

export default ReminderPage;