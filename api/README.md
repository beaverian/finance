# Multi-Tenant AR/AP System with Rails API and React Frontend

This project is a multi-tenant application built with a Rails API backend and a React frontend. It is designed as an AR/AP (Accounts Receivable/Accounts Payable) system, supporting user roles and an admin dashboard for managing users, billing, and tenant-specific settings.

## Table of Contents

- [Getting Started](#getting-started)
- [Features](#features)
- [Setup Instructions](#setup-instructions)
- [API Endpoints](#api-endpoints)
- [Frontend Components](#frontend-components)
- [Running Tests](#running-tests)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Prerequisites

Ensure you have the following installed on your development environment:

- Ruby (version 3.x or higher)
- Rails (version 7.2 or higher)
- Node.js (version 14.x or higher)
- Yarn (version 1.x or higher)
- PostgreSQL (or your preferred database)

### Setup Instructions

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/multi-tenant-app.git
    cd multi-tenant-app
    ```

2. **Install backend dependencies:**

    ```bash
    bundle install
    ```

3. **Install frontend dependencies:**

    ```bash
    cd frontend
    yarn install
    ```

4. **Set up the database:**

    - Create and migrate the database:

      ```bash
      rails db:create db:migrate
      ```

    - Seed the database with initial data:

      ```bash
      rails db:seed
      ```

5. **Start the Rails server:**

    ```bash
    rails server
    ```

6. **Start the React development server:**

    ```bash
    cd frontend
    yarn start
    ```

7. **Access the application:**

   - Backend API: `http://localhost:3000/api/v1`
   - React Frontend: `http://localhost:3001`

## Features

- **Multi-Tenancy:** Each tenant has isolated data, managed through a single Rails database.
- **AR/AP System:** The application is designed to handle accounts receivable and accounts payable processes within a multi-tenant environment.
- **User Management:** Admin users can manage users within their tenant, assigning roles like admin and user.
- **Role-Based Access Control:** Access to different parts of the application is controlled by user roles.
- **Admin Dashboard:** Tenant administrators have access to a dashboard for managing users, billing, and settings.

## API Endpoints

### User Management

- **GET /api/v1/admin/users** - List all users for the current tenant.
- **POST /api/v1/admin/users** - Create a new user.
- **GET /api/v1/admin/users/:id** - Retrieve a specific user.
- **PUT /api/v1/admin/users/:id** - Update a user's details.
- **DELETE /api/v1/admin/users/:id** - Delete a user.

### Tenant Settings

- **GET /api/v1/admin/settings** - Retrieve current tenant settings.
- **PUT /api/v1/admin/settings** - Update tenant settings.

## Frontend Components

### `UserList`

- Displays a list of users for the current tenant.
- Fetches data from the `/api/v1/admin/users` endpoint.

### `UserForm`

- Form for creating or updating users.
- Posts or updates data to the `/api/v1/admin/users` endpoint.

### `AdminDashboard`

- Main dashboard component that integrates `UserList` and `UserForm`.
- Provides access to tenant-specific management tools, including user management and AR/AP processes.

## Running Tests

### Backend

To run the Rails test suite:

```bash
rails test
