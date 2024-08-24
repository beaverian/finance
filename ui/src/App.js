import React from 'react';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import AdminDashboard from './components/AdminDashboard';
import Login from './components/Login';
import ProtectedRoute from './components/ProtectedRoute';
import RegistrationForm from './components/RegistrationForm';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/register" element={<RegistrationForm />} />
        <Route path="/login" element={<Login />} />
        <Route path="/admin" element={<ProtectedRoute component={AdminDashboard} />} />
        <Route path="*" element={<Navigate to="/login" />} />
      </Routes>
    </Router>
  );
}

export default App;
