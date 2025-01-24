# Step 1: Build the app using Node.js
FROM node:16 AS build

WORKDIR /app

# Copy dependencies and install them
COPY package.json package-lock.json ./
RUN npm install

# Copy the source code
COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve the app using NGINX
FROM nginx:alpine

# Copy the built React app to NGINX's directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run NGINX to serve the app
CMD ["nginx", "-g", "daemon off;"]
