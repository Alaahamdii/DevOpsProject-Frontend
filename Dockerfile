# Stage 1: Build the Angular application
FROM node:21.1.0-slim AS builder

WORKDIR /app

# Copy the package.json and package-lock.json files for dependency installation
COPY package*.json ./

# Install the Node.js application dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of your application code (Angular source code)
COPY . .

# Build the Angular application (assumes you have an npm script "build" defined in your package.json)
RUN npm run build 

# Define the command to start the application (it's optional and not used in this stage)
CMD ["npm", "start"]

# Stage 2: Create the Nginx image to serve the built app
FROM nginx:alpine
# Copy the Nginx configuration
COPY default.conf /etc/nginx/conf.d
# Copy the build artifacts from the builder stage
COPY --from=builder /app/dist/summer-workshop-angular/ /usr/share/nginx/html
EXPOSE 80


