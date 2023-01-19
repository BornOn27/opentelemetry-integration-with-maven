FROM maven:3.8.6-amazoncorretto-8 AS build


COPY config-extension /app/config-extension
RUN mvn -f /app/config-extension/pom.xml clean package

COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package spring-boot:repackage

FROM openjdk:8-jdk
COPY --from=build /app/target/opentelemetry-integration-with-maven-1.0-SNAPSHOT.jar /opt/app.jar
COPY --from=build /app/config-extension/target/config-extension-1.jar /opt/config-extension.jar
COPY --from=build /app/target/otel/opentelemetry-javaagent.jar /opt/

EXPOSE 8080
WORKDIR /opt
CMD ["java", "-javaagent:/opt/opentelemetry-javaagent.jar", "-Dotel.javaagent.extensions=/opt/config-extension.jar", "-jar", "app.jar"]