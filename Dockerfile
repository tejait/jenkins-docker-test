# --- STAGE 1: Builder ---
# Use a full JDK image to compile the application.
# We choose a common base like eclipse-temurin for reliable, optimized images.
FROM eclipse-temurin:17-jdk-jammy AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven/Gradle project files (pom.xml, build.gradle, etc.)
# and the source code.
# This copies the project structure.
COPY . .

# IMPORTANT: Run the build command (e.g., Maven clean install or Gradle build).
# We skip tests here to speed up the image build, assuming they run in CI/CD.
# For Maven:
RUN ./mvnw package -DskipTests

# For Gradle, you would use:
# RUN ./gradlew bootJar -x test


# --- STAGE 2: Runtime ---
# Use a minimal JRE image for the final, smaller runtime image.
# We switch to the JRE variant of the same base image.
FROM eclipse-temurin:17-jre-jammy AS runtime

# Set a non-root user for security (optional but recommended)
# We can use the default 'nonroot' user if available, or create one.
# For simplicity, we stick to the default for this example.

# Set the working directory
WORKDIR /app

# Expose the port the Spring Boot application listens on (default is 8080)
EXPOSE 8080

# Copy the built JAR file from the 'builder' stage
# The name of the JAR file depends on your project name and version.
# Adjust 'your-app-name-0.0.1-SNAPSHOT.jar' to your actual JAR name.
# You can find the exact name in your target/ or build/libs/ directory.
COPY --from=builder /app/target/*.jar app.jar

# Define the entrypoint to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]