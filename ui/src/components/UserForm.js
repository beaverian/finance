import React, { useState } from 'react';
import API from '../services/api';

const UserForm = ({ user = {}, onSave }) => {
  const [name, setName] = useState(user.name || '');
  const [email, setEmail] = useState(user.email || '');
  const [role, setRole] = useState(user.role || 'user');

  const handleSubmit = (e) => {
    e.preventDefault();
    const method = user.id ? 'put' : 'post';
    const url = user.id ? `/admin/users/${user.id}` : '/admin/users';

    API[method](url, { name, email, role })
      .then((response) => onSave(response.data))
      .catch((error) => console.error(error));
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>Name:</label>
        <input type="text" value={name} onChange={(e) => setName(e.target.value)} />
      </div>
      <div>
        <label>Email:</label>
        <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
      </div>
      <div>
        <label>Role:</label>
        <select value={role} onChange={(e) => setRole(e.target.value)}>
          <option value="user">User</option>
          <option value="admin">Admin</option>
        </select>
      </div>
      <button type="submit">Save</button>
    </form>
  );
};

export default UserForm;
