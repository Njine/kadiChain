# Stage 1: Build the app
FROM node:18 AS build
WORKDIR /app
COPY /package*.json ./
RUN npm install
COPY frontend .
RUN npm run build

# Stage 2: Serve the app
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
