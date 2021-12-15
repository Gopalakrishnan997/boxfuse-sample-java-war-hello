# Build the application first using Maven
FROM maven:3.8-openjdk-8 as build
WORKDIR /app
COPY . .
RUN mvn install

# Inject the JAR file into a new container to keep the file small
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/hello-java-spring-boot-*.war /app/app.war
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java -war app.war"]
