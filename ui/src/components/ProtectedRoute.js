import React from 'react';
import { Navigate } from 'react-router-dom';

const isAuthenticated = () => {
  return localStorage.getItem('authToken') !== null;
};

const ProtectedRoute = ({ component: Component }) => {
  return isAuthenticated() ? <Component /> : <Navigate to="/login" />;
};

export default ProtectedRoute;
