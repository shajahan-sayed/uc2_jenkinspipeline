# Use OpenJDK 11 base image
FROM eclipse-temurin:11-jdk

# Set work directory
WORKDIR /app

# Copy the jar built by Maven
COPY target/uc2_jenkinspipeline-1.0.0.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
