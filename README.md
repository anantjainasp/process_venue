# Book Review API

A complete JavaScript implementation of the Book Review API using Express.js, Sequelize, PostgreSQL, and Redis.

## Features

- **Express.js** with modern ES6+ modules
- **Sequelize ORM** for PostgreSQL database operations
- **Redis caching** with graceful fallback
- **Joi validation** for request validation
- **Swagger documentation** with interactive UI
- **Jest testing** for unit and integration tests
- **Security middleware** (Helmet, CORS, Rate Limiting)
- **Error handling** with proper HTTP status codes

## API Endpoints

### Books
- `GET /api/v1/books` - List all books (with caching)
- `POST /api/v1/books` - Create a new book
- `GET /api/v1/books/:id` - Get a specific book
- `PUT /api/v1/books/:id` - Update a book
- `DELETE /api/v1/books/:id` - Delete a book

### Reviews
- `GET /api/v1/books/:id/reviews` - Get reviews for a book (with caching)
- `POST /api/v1/books/:id/reviews` - Add a review to a book
- `GET /api/v1/reviews/:id` - Get a specific review
- `PUT /api/v1/reviews/:id` - Update a review
- `DELETE /api/v1/reviews/:id` - Delete a review

## Quick Start

### Prerequisites

- Node.js 18+
- PostgreSQL database
- Redis server  
- Docker (optional, for easy database setup)

### 1. Install Dependencies
```bash
npm install
```

### 2. Environment Setup
Update the `.env` file with your database and Redis configuration.

### 3. Start Services
```bash
# Start PostgreSQL and Redis
docker compose up -d

# Or start manually:
# PostgreSQL on port 5432
# Redis on port 6379
```

### 4. Run the Application
```bash
# Development mode
npm run dev

# Production mode
npm start
```

### 5. Run Tests
```bash
npm test
```

## API Documentation

Visit `http://localhost:3001/api/docs` for interactive Swagger documentation.

## Key Features Demonstrated

### 1. Caching Strategy
- Cache-first approach with Redis
- Graceful fallback to database when cache fails
- Smart cache invalidation on data changes
- Console logging shows cache hits vs database queries

### 2. Database Optimization
- Sequelize models with proper relationships
- Indexed queries for performance (bookId index on reviews)
- Foreign key constraints with cascade deletes

### 3. Error Handling
- Comprehensive error middleware
- Proper HTTP status codes
- Validation errors with detailed messages
- Database error handling

### 4. Testing
- Jest testing framework
- Unit tests for services
- Integration tests for API endpoints
- Cache behavior testing

### 5. Security
- Helmet for security headers
- CORS configuration
- Rate limiting
- Input validation with Joi

## Project Structure

```
express-version/
├── src/
│   ├── config/         # Database and Redis configuration
│   ├── models/         # Sequelize models
│   ├── controllers/    # Route controllers
│   ├── services/       # Business logic
│   ├── routes/         # Express routes
│   ├── middleware/     # Custom middleware
│   ├── validators/     # Joi schemas
│   └── app.js         # Main application
├── tests/             # Test files
├── package.json       # Dependencies
└── .env              # Environment variables
```

## Sample Usage

### Create a Book
```bash
curl -X POST http://localhost:3001/api/v1/books \
  -H "Content-Type: application/json" \
  -d '{
    "title": "The Great Gatsby",
    "author": "F. Scott Fitzgerald",
    "description": "A classic American novel",
    "isbn": "9780743273565",
    "publicationYear": 1925
  }'
```

### Get All Books (demonstrates caching)
```bash
# First call - database
curl http://localhost:3001/api/v1/books

# Second call - cache
curl http://localhost:3001/api/v1/books
```

### Add a Review
```bash
curl -X POST http://localhost:3001/api/v1/books/1/reviews \
  -H "Content-Type: application/json" \
  -d '{
    "reviewerName": "John Doe",
    "rating": 5,
    "comment": "Excellent book!"
  }'
```

## Performance & Caching

The application demonstrates excellent caching behavior:
- Console logs show "📦 Retrieved from cache" vs "🗄️ Retrieved from database"
- First requests hit the database and populate cache
- Subsequent requests serve from cache (much faster)
- Cache invalidation on create/update/delete operations
- Graceful fallback when Redis is unavailable

This Express.js implementation provides robust, scalable API functionality with comprehensive caching and error handling!
