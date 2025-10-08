// src/routes/AppRoutes.jsx
import { Routes, Route, Navigate } from 'react-router-dom';

// Layouts and Pages
import MainLayout from '../layouts/MainLayout';
import LoginPage from '../features/auth/LoginPage';
import ProtectedRoute from './ProtectedRoute';
import Dashboard from '../features/dashboard/Dashboard';
import UserList from '../features/users/UserList';
import NotificationPage from '../features/notifications/NotificationPage';
import ReminderPage from '../features/reminders/ReminderPage'; // 1. IMPORT the new page component

// Content Components
import ContentLayout from '../features/content/ContentLayout';
import MovieUpload from '../features/content/MovieUpload';
import SeriesList from '../features/content/SeriesList';
import SeriesDetail from '../features/content/SeriesDetail';
import AudioUpload from '../features/content/AudioUpload';

const AppRoutes = () => {
  return (
    <Routes>
      {/* Public Route: Login Page */}
      <Route path="/login" element={<LoginPage />} />

      {/* Protected Routes */}
      <Route element={<ProtectedRoute />}>
        <Route path="/" element={<MainLayout />}>
          <Route index element={<Navigate to="/dashboard" replace />} />
          <Route path="dashboard" element={<Dashboard />} />

          {/* Content Routes */}
          <Route path="content" element={<ContentLayout />}>
            <Route index element={<Navigate to="movies" replace />} />
            <Route path="movies" element={<MovieUpload />} />
            <Route path="series" element={<SeriesList />} />
            <Route path="series/:seriesId" element={<SeriesDetail />} />
            <Route path="audio" element={<AudioUpload />} />
          </Route>
          
          <Route path="notifications" element={<NotificationPage />} />
          
          {/* 2. ADD the new route for the reminders page */}
          <Route path="reminders" element={<ReminderPage />} />
          
          <Route path="users" element={<UserList />} />
        </Route>
      </Route>
    </Routes>
  );
};

export default AppRoutes;