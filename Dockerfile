# FROM eclipse-temurin:11-jdk as base

# ADD ./newrelic/newrelic.jar ./newrelic/newrelic.jar
# ADD ./newrelic/newrelic.yml /usr/local/tomcat/newrelic/newrelic.yml

# RUN mkdir -p /usr/local/tomcat/newrelic/logs
# RUN chown -R tomcat:tomcat /usr/local/tomcat/newrelic/logs

# COPY ./ ./
# RUN ./gradlew bootJar

# FROM eclipse-temurin:11

# COPY --from=base /build/libs/fibonacci-java.jar /app.jar

# ENTRYPOINT java -jar app.jar

# RUN mkdir -p /usr/local/tomcat/newrelic/logs
# RUN chown -R tomcat:tomcat /usr/local/tomcat/newrelic/logs

# FROM openjdk:8
# ADD fibonacci-java.jar /app
# ADD newrelic.jar  /app
# ADD newrelic.yml  /app 
# ENV NEW_RELIC_APP_NAME="fibonacci-java"
# ENV NEW_RELIC_LICENSE_KEY="747d4704ef1bf95b94ff8f4e349f09583b3dNRAL"

# RUN mkdir -p /usr/local/tomcat/newrelic/logs
# RUN chown -R tomcat:tomcat /usr/local/tomcat/newrelic/logs

# COPY ./ ./
# RUN ./gradlew bootJar

# ENTRYPOINT ["java","-javaagent:/app/newrelic.jar","-jar","/app.jar"]

# ENTRYPOINT ["java","-javaagent:./newrelic/newrelic.jar","-jar","app.jar"]

FROM tomcat:9
# Add the newrelic.jar and -javaagent parameters
RUN mkdir -p ./newrelic/newrelic
ADD ./newrelic/newrelic.jar ./newrelic
ENV JAVA_OPTS="$JAVA_OPTS -javaagent:./newrelic/newrelic.jar"
# Add the configuration file
ADD ./newrelic/newrelic.yml ./newrelic/newrelic
# An example of setting a system property config
ENV JAVA_OPTS="$JAVA_OPTS -Dnewrelic.config.app_name='fibonacci-java'"
# An example of setting an Environment variable config
ENV NEW_RELIC_LICENSE_KEY="747d4704ef1bf95b94ff8f4e349f09583b3dNRAL"
# Config to include the agent logs in Docker's stdout logging
# ENV JAVA_OPTS="$JAVA_OPTS -Dnewrelic.config.log_file_name=STDOUT"
# EXPOSE 8080
CMD ["catalina.sh", "run"]
ENTRYPOINT ["java","-javaagent:./newrelic/newrelic.jar","-jar","app.jar"]