# ---------- STAGE 1: Build ----------
FROM maven:3.9-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy Maven project
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package -DskipTests

# ---------- STAGE 2: Output ----------
FROM alpine:latest

# Create output folder
WORKDIR /output

# Copy built JAR from builder stage
COPY --from=build /app/target/*.jar ./username-validator.jar

# Default output location: /output/username-validator.jar
