// src/features/users/UserList.jsx
import React from 'react';
import { Box, Typography, IconButton } from '@mui/material';
import { DataGrid } from '@mui/x-data-grid';
import DeleteIcon from '@mui/icons-material/Delete';
import LockResetIcon from '@mui/icons-material/LockReset';
import { mockUsers } from './mockUserData'; // Importing our fake data

const UserList = () => {
  // Define the columns for our DataGrid
  const columns = [
    { field: 'id', headerName: 'User ID', width: 90 },
    { field: 'name', headerName: 'Name', width: 180, editable: true },
    { field: 'email', headerName: 'Email', width: 220, editable: true },
    { field: 'phoneNumber', headerName: 'Phone Number', width: 150 },
    { field: 'registrationDate', headerName: 'Registration Date', width: 180 },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 150,
      sortable: false,
      renderCell: (params) => {
        const onClickDelete = () => {
          // Logic to delete user
          console.log('Delete user:', params.row.id);
          alert(`Delete user ${params.row.name}? (Functionality to be added)`);
        };

        const onClickResetPassword = () => {
          // Logic to reset password
          console.log('Reset password for user:', params.row.id);
          alert(`Reset password for ${params.row.name}? (Functionality to be added)`);
        };

        return (
          <Box>
            <IconButton color="primary" onClick={onClickResetPassword}>
              <LockResetIcon />
            </IconButton>
            <IconButton color="error" onClick={onClickDelete}>
              <DeleteIcon />
            </IconButton>
          </Box>
        );
      },
    },
  ];

  // Use the mock data as the rows for our table
  const rows = mockUsers;

  return (
    <Box sx={{ height: 'calc(100vh - 128px)', width: '100%' }}>
      <Typography variant="h4" sx={{ mb: 3 }}>
        User List
      </Typography>
      <DataGrid
        rows={rows}
        columns={columns}
        pageSize={10}
        rowsPerPageOptions={[10]}
        checkboxSelection
        disableSelectionOnClick
        sx={{
          // This removes the border from the DataGrid
          border: 0,
        }}
      />
    </Box>
  );
};

export default UserList;