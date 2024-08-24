import React, { useState } from 'react';
import axios from 'axios';
import { Form, Button, Container, Row, Col, Alert } from 'react-bootstrap';
import ToastMessage from './ToastMessage';

const RegistrationForm = () => {
  // State hooks for form fields and message
  const [tenantName, setTenantName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [passwordConfirmation, setPasswordConfirmation] = useState('');
  const [message, setMessage] = useState('');
  const [variant, setVariant] = useState('success');
  const [showToast, setShowToast] = useState(false);

  /**
   * Handles form submission.
   * Sends a POST request to the registration endpoint with tenant and user data.
   * @param {Event} e - The form submission event.
   */
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://localhost:4000/api/v1/register', {
        tenant: { name: tenantName },
        user: { email, password, password_confirmation: passwordConfirmation }
      });
      setMessage(response.data.message);
      setVariant('success');
    } catch (error) {
      if (error.response && error.response.data && error.response.data.errors) {
        setMessage(error.response.data.errors.join(', '));
      } else {
        setMessage('An unexpected error occurred.');
      }
      setVariant('danger');
    }
  };

  return (
    <Container>
      <Row className="justify-content-md-center">
        <Col md={6}>
          <h2 className="my-4">Register</h2>
          {message && <Alert variant={variant}>{message}</Alert>}
          <Form onSubmit={handleSubmit}>
            <Form.Group controlId="formTenantName">
              <Form.Label>Tenant Name</Form.Label>
              <Form.Control
                type="text"
                value={tenantName}
                onChange={(e) => setTenantName(e.target.value)}
                required
              />
            </Form.Group>
            <Form.Group controlId="formEmail">
              <Form.Label>Email</Form.Label>
              <Form.Control
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
            </Form.Group>
            <Form.Group controlId="formPassword">
              <Form.Label>Password</Form.Label>
              <Form.Control
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </Form.Group>
            <Form.Group controlId="formPasswordConfirmation">
              <Form.Label>Confirm Password</Form.Label>
              <Form.Control
                type="password"
                value={passwordConfirmation}
                onChange={(e) => setPasswordConfirmation(e.target.value)}
                required
              />
            </Form.Group>
            <Button variant="primary" type="submit" className="mt-3">
              Register
            </Button>
          </Form>
        </Col>
      </Row>
    </Container>
  );
};

export default RegistrationForm;
