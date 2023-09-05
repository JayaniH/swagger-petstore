FROM openjdk:8-jre-alpine

ADD . /swagger-petstore
WORKDIR /swagger-petstore

RUN ls -l

RUN mvn clean install

RUN ls -l

COPY target/lib/jetty-runner.jar /swagger-petstore/jetty-runner.jar
COPY target/*.war /swagger-petstore/server.war
COPY src/main/resources/openapi.yaml /swagger-petstore/openapi.yaml
COPY inflector.yaml /swagger-petstore/

EXPOSE 8080

USER 10014

CMD ["java", "-jar", "-DswaggerUrl=openapi.yaml", "/swagger-petstore/jetty-runner.jar", "/swagger-petstore/server.war"]
