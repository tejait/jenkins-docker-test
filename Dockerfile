FROM eclipse-temurin:21-jre-jammy-slim
WORKDIR /app
COPY target/springboot-jenkins-docker-test<.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
