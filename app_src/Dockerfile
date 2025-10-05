FROM openjdk:17-jdk-alpine as builder
ARG buildver=3.2.0

WORKDIR /app

COPY . .

RUN ./gradlew build -x test

FROM openjdk:17-jdk-alpine as prod
ARG buildver=3.2.0

COPY --from=builder /app/build/libs/spring-petclinic-${buildver}.jar /app/spring-petclinic.jar

#

ENTRYPOINT ["java", "-jar", "/app/spring-petclinic.jar"]