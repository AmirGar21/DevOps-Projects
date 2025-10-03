FROM openjdk:17-slim AS build

WORKDIR /app

COPY pom.xml .           
RUN mkdir .mvn            
COPY .mvn/ .mvn/           
COPY mvnw .               
RUN chmod +x mvnw    

RUN ./mvnw dependency:go-offline
COPY src/ src/

RUN ./mvnw package -DskipTests


FROM eclipse-temurin:17-jre AS runtime

WORKDIR /app
COPY --from=build /app/target/hotel-service-0.0.1-SNAPSHOT.jar ./hotel-service.jar
COPY wait-for-it.sh .

RUN chmod +x wait-for-it.sh
RUN useradd -r appuser

USER appuser

CMD ["./wait-for-it.sh", "postgres:5432", "--", "java", "-jar", "hotel-service.jar"]