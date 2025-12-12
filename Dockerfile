# ----------- Build Stage -----------
FROM eclipse-temurin:21 AS builder
WORKDIR /app

# Copy Maven wrapper and pom
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml .

# Download dependencies (layer caching)
RUN ./mvnw -B dependency:go-offline

# Copy source code and build jar
COPY src ./src
RUN ./mvnw -B clean package -DskipTests


# ----------- Final Runtime Stage -----------
FROM eclipse-temurin:21
WORKDIR /app

# Copy jar file from builder's target directory
COPY --from=builder /app/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
