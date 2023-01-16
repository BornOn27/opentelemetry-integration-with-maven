FROM maven:3.8.6-amazoncorretto-8 AS build


COPY config-extension /home/app/config-extension
RUN mvn -f /home/app/config-extension/pom.xml clean package

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package spring-boot:repackage

FROM openjdk:8-jdk
COPY --from=build /home/app/target/opentelemetry-integration-with-maven-0.0.1-SNAPSHOT.jar /opt/app.jar
COPY --from=build /home/app/config-extension/target/config-extension-1.jar /opt/config-extension.jar
COPY --from=build /home/app/target/otel/opentelemetry-javaagent.jar /opt/

EXPOSE 8080
WORKDIR /opt
CMD ["java", "-jar", "app.jar"]