# --- Stage 1: Build the app ---
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# --- Stage 2: Run the app (minimal image) ---
FROM node:20-alpine

WORKDIR /app

# Copy built app + node_modules
COPY --from=build /app .

# Run the server
CMD ["node", "index.js"]


