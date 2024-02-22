FROM openjdk:21
VOLUME /tmp
EXPOSE 8080
ARG VERSION
ARG JAR_FILE=build/libs/api-gateway-${VERSION}.jar
ADD ${JAR_FILE} app/app.jar
ENTRYPOINT ["java","-Dspring.config.location=/app/config/","-jar","app/app.jar"]