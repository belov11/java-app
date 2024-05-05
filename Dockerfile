FROM maven:3-openjdk-11 as build
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN mvn -DskipTests package

FROM openjdk:8-slim
RUN mkdir /project
COPY --from=build /app/target/employee-management-0.0.1-SNAPSHOT.jar /project/app.jar
WORKDIR /project
EXPOSE 8080/tcp
ENTRYPOINT ["java", "-jar", "/project/app.jar"]

