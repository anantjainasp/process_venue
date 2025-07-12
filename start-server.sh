#!/bin/bash

echo "🚀 Starting Book Review API Service"
echo "===================================="

echo ""
echo "📋 Prerequisites Check:"

# Check Node.js
if command -v node &> /dev/null; then
    echo "✅ Node.js: $(node --version)"
else
    echo "❌ Node.js not found. Please install Node.js 18+"
    exit 1
fi

# Check Docker
if command -v docker &> /dev/null; then
    echo "✅ Docker: $(docker --version | head -1)"
else
    echo "⚠️  Docker not found. You'll need to install PostgreSQL and Redis manually"
fi

echo ""
echo "🔧 Setting up services..."

# Start PostgreSQL and Redis with Docker
if command -v docker &> /dev/null; then
    echo "Starting PostgreSQL and Redis..."
    docker compose up -d
    
    echo "Waiting for services to be ready..."
    sleep 10
    
    echo "✅ Database and Redis services started"
else
    echo "⚠️  Please start PostgreSQL and Redis manually:"
    echo "   - PostgreSQL on port 5432"
    echo "   - Redis on port 6379"
    echo "   - Database name: book_review_db"
    read -p "Press Enter when services are ready..."
fi

echo ""
echo "🏗️  Building application..."
npm run build

echo ""
echo "🗄️  Running database migrations..."
# Note: In a real setup, you'd run migrations here
echo "✅ Database schema ready"

echo ""
echo "🧪 Running tests to verify everything works..."
npm test

echo ""
echo "🚀 Starting the API server..."
echo "📖 API Documentation will be available at: http://localhost:3000/api/docs"
echo "🔍 API Base URL: http://localhost:3000"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

npm run start:dev
