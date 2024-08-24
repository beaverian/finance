import React, { useState } from 'react';
import UserList from './UserList';
import UserForm from './UserForm';

const AdminDashboard = () => {
  const [selectedUser, setSelectedUser] = useState(null);

  const handleUserSelect = (user) => {
    setSelectedUser(user);
  };

  const handleUserSave = (user) => {
    setSelectedUser(null); // Close the form after saving
    // Optionally refresh the user list
  };

  return (
    <div>
      <h1>Admin Dashboard</h1>
      <UserList onUserSelect={handleUserSelect} />
      <UserForm user={selectedUser} onSave={handleUserSave} />
    </div>
  );
};

export default AdminDashboard;
