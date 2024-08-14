# Stage 1: Build the WAR file
FROM maven:3.8.4-openjdk-11 AS builder

WORKDIR /app

# Copy the project files and build
COPY pom.xml ./
COPY src ./src
RUN mvn clean package

# Stage 2: Create the Tomcat image
FROM tomcat:9

LABEL maintainer="hippo"

# Copy the WAR file from the builder stage
COPY --from=builder /app/target/your-app.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
