// src/styles/theme.js
import { createTheme, alpha } from '@mui/material/styles';

const GOLDEN_ACCENT = '#F2C22E';

// We create a common settings object to avoid repeating code.
// This is where we'll define things that are the same for both themes.
const commonSettings = {
  // NEW: Add a global border radius to soften all components.
  shape: {
    borderRadius: 8,
  },
  // NEW: Add global styles for specific components.
  components: {
    // Style for all Paper components (cards, forms, tables)
    MuiPaper: {
      styleOverrides: {
        root: {
          // Remove the default box-shadow for a cleaner look.
          // We will use borders or custom shadows where needed.
          boxShadow: 'none',
        },
      },
    },
    // Style for the primary buttons
    MuiButton: {
      styleOverrides: {
        // Target the contained variant
        containedSecondary: {
          // Set the text color to black for better contrast on the gold background
          color: '#111827',
          fontWeight: 'bold',
          // Add a subtle shadow on hover for a nice effect
          '&:hover': {
            boxShadow: `0px 4px 12px ${alpha(GOLDEN_ACCENT, 0.3)}`,
          },
        },
      },
    },
  },
};


// --- LIGHT THEME ---
export const lightTheme = createTheme({
  ...commonSettings, // Apply the common settings
  palette: {
    mode: 'light',
    primary: {
      main: '#111827',
    },
    secondary: {
      main: GOLDEN_ACCENT,
    },
    background: {
      default: '#F9FAFB', // This very light grey will be our main page background
      paper: '#FFFFFF',   // All Paper components will be pure white
    },
    text: {
      primary: '#111827',
      secondary: '#6B7280',
    },
    // NEW: Define a specific color for dividers/borders
    divider: '#E5E7EB',
  },
});


// --- DARK THEME ---
export const darkTheme = createTheme({
  ...commonSettings, // Apply the same common settings
  palette: {
    mode: 'dark',
    primary: {
      main: '#FFFFFF',
    },
    secondary: {
      main: GOLDEN_ACCENT,
    },
    background: {
      default: '#111827', // The main page background
      paper: '#1F2937',   // The color for cards and forms
    },
    text: {
      primary: '#FFFFFF',
      secondary: '#9CA3AF',
    },
    // NEW: A lighter divider for dark mode
    divider: alpha('#FFFFFF', 0.12),
  },
});