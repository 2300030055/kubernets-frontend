# Stage 1: Build React app
FROM node:18 AS build-stage
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Stage 2: Serve build with Tomcat
FROM tomcat:9-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy Vite build output (dist) into Tomcat ROOT
COPY --from=build-stage /app/dist /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
