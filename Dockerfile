FROM 029197504624.dkr.ecr.us-east-1.amazonaws.com/openjdk_17_jdk_slim
WORKDIR /app
COPY target/demo-1.0.0.jar app.jar
EXPOSE 9090
CMD ["java", "-jar", "app.jar", "--server.port=9090"]
