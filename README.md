# IlloFlex API

IlloFlex API is the backend service of IlloFlex, a vocational guidance platform focused on Andalusia.

It provides the logic and data layer for the anonymous RIASEC-based test, result calculation, recommendations, and temporary result recovery by email link.

## Main Features

- Anonymous vocational tests identified by UUID
- Answer storage and update
- Test completion validation
- Normalized RIASEC result calculation
- Professional family and training cycle recommendations
- Temporary result link generation
- Result recovery through secure token links
- Email delivery of temporary links

## Tech Stack

- Node.js
- Express
- Sequelize
- MySQL
- Nodemailer

## Project Structure

- `routes` for API endpoints
- `controllers` for request/response handling
- `services` for business logic
- `models` for persistence
- `repositories` for specific data queries
- `config` for environment and database configuration

## Dependencies and Local Setup

Install dependencies:

```bash
npm install
```

Run in development mode:

```bash
npm run dev
```

Run in standard mode:

```bash
npm start
```
