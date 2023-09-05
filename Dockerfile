FROM openjdk:8-jre-alpine

ADD . /swagger-petstore
WORKDIR /swagger-petstore

RUN mvn clean install

COPY swagger-petstore/target/lib/jetty-runner.jar /swagger-petstore/jetty-runner.jar
COPY swagger-petstore/target/*.war /swagger-petstore/server.war
COPY swagger-petstore/src/main/resources/openapi.yaml /swagger-petstore/openapi.yaml
COPY swagger-petstore/inflector.yaml /swagger-petstore/

EXPOSE 8080

USER 10014

CMD ["java", "-jar", "-DswaggerUrl=openapi.yaml", "/swagger-petstore/jetty-runner.jar", "/swagger-petstore/server.war"]
