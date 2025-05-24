# Stage 1: Build the Java app
FROM maven:3.8.7-openjdk-17 AS build

WORKDIR /app

# Copy your source code and pom.xml
COPY pom.xml .
COPY src ./src

# Build the app (assuming it's a Maven project)
RUN mvn clean package -DskipTests

# Stage 2: Deploy app to Tomcat
FROM tomcat:9.0-jdk17

# Remove default web apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR built in the previous stage to Tomcat webapps
COPY --from=build /app/target/calculator.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

CMD ["catalina.sh", "run"]
