# Build stage
FROM maven:3.8.1-openjdk-11 as builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Runtime stage
FROM tomcat:9.0
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/
