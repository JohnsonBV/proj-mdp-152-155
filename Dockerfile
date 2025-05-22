# Stage 1: Build the application
FROM maven:3.8.6-openjdk-11-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0
COPY --from=builder /app/target/WebAppCal-*.war /usr/local/tomcat/webapps/WebAppCal.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

