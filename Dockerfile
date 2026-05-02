FROM node:24-alpine

# Install dependencies needed for building native modules (optional)
RUN apk add --no-cache python3 make g++ git

WORKDIR /app

# Install dependencies first (better caching)
COPY package*.json ./
RUN npm install --production=false

# Copy the rest of the project
COPY . .

# Build TypeScript → JavaScript
RUN npm run build

# Expose port if your app listens on one
# EXPOSE 3000

# Start the compiled app
CMD ["node", "dist/index.js"]
