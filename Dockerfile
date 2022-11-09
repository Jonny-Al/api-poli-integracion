FROM openjdk:8-jdk-alpine
COPY target/api-rest-appday-1.0.0.0-SNAPSHOT.jar api-rest-appday-1.0.0.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/api-rest-appday-1.0.0.0-SNAPSHOT.jar"]