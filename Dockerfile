# Use the stable Eclipse Temurin image
FROM eclipse-temurin:17-jdk-jammy

# Set the working directory
WORKDIR /App

# Copy your Java files into the container
COPY . .

# Compile your Java file (Ensure your file is named App.java)
RUN javac App.java

# Run the application
CMD ["java", "App"]