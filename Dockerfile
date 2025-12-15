# Use OpenJDK 11 base image
FROM openjdk:11.0.20-slim-bullseye

# Set work directory
WORKDIR /app

# Copy the jar built by Maven
COPY target/uc2_jenkinspipeline-1.0.0.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
