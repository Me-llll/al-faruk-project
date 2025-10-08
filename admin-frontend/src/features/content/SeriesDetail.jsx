// src/features/content/SeriesDetail.jsx
import React, { useState, useEffect } from 'react';
import { useParams, Link as RouterLink } from 'react-router-dom';
import { Box, Typography, Paper, List, ListItem, ListItemButton, ListItemText, Breadcrumbs, Link, Grid } from '@mui/material';
import AddSeasonForm from './AddSeasonForm';
import EpisodeManager from './EpisodeManager';
import PageHeader from '../../components/PageHeader';

// Mock data fetching function
const fetchSeriesData = (seriesId) => {
  // In a real app, this would be an API call
  console.log(`Fetching data for series ID: ${seriesId}`);
  const series = {
    id: seriesId,
    title: `Series Title ${seriesId}`,
    description: 'A detailed description of the series goes here. It tells the story and introduces the main characters.',
    seasons: [
      { id: 1, title: 'Season 1', episodes: [{ id: 1, title: 'Episode 1: The Beginning' }, { id: 2, title: 'Episode 2: The Journey' }] },
      { id: 2, title: 'Season 2', episodes: [{ id: 3, title: 'Episode 3: The Challenge' }] },
    ],
  };
  return new Promise(resolve => setTimeout(() => resolve(series), 500));
};

const SeriesDetail = () => {
  const { seriesId } = useParams(); // Get the ID from the URL
  const [series, setSeries] = useState(null);
  const [selectedSeason, setSelectedSeason] = useState(null);

  useEffect(() => {
    fetchSeriesData(seriesId).then(data => {
      setSeries(data);
      // Select the first season by default if it exists
      if (data.seasons.length > 0) {
        setSelectedSeason(data.seasons[0]);
      }
    });
  }, [seriesId]);

  const handleAddSeason = (seasonTitle) => {
    const newSeason = {
      id: series.seasons.length + 1,
      title: seasonTitle,
      episodes: [],
    };
    setSeries({ ...series, seasons: [...series.seasons, newSeason] });
  };
  
  const handleAddEpisode = (seasonId, episodeData) => {
    const updatedSeasons = series.seasons.map(season => {
      if (season.id === seasonId) {
        const newEpisode = { id: season.episodes.length + 1, title: episodeData.episodeTitle };
        return { ...season, episodes: [...season.episodes, newEpisode] };
      }
      return season;
    });
    setSeries({ ...series, seasons: updatedSeasons });
    // Refresh selectedSeason to show the new episode
    setSelectedSeason(updatedSeasons.find(s => s.id === seasonId));
  };

  if (!series) {
    return <Typography>Loading series data...</Typography>;
  }

  return (
    <Box>
      <Breadcrumbs aria-label="breadcrumb" sx={{ mb: 2 }}>
        <Link component={RouterLink} underline="hover" color="inherit" to="/content/series">Series</Link>
        <Typography color="text.primary">{series.title}</Typography>
      </Breadcrumbs>
      <PageHeader title={series.title} subtitle={series.description} />
      
      <Grid container spacing={4}>
        {/* Left Column: Seasons List */}
        <Grid item xs={12} md={4}>
          <Paper sx={{ p: 2 }}>
            <Typography variant="h6" sx={{ mb: 1 }}>Seasons</Typography>
            <List>
              {series.seasons.map((season) => (
                <ListItemButton
                  key={season.id}
                  selected={selectedSeason?.id === season.id}
                  onClick={() => setSelectedSeason(season)}
                >
                  <ListItemText primary={season.title} />
                </ListItemButton>
              ))}
            </List>
          </Paper>
          <AddSeasonForm onSubmit={handleAddSeason} />
        </Grid>

        {/* Right Column: Episode Manager */}
        <Grid item xs={12} md={8}>
          <EpisodeManager selectedSeason={selectedSeason} onEpisodeSubmit={handleAddEpisode} />
        </Grid>
      </Grid>
    </Box>
  );
};

export default SeriesDetail;