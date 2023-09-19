# Use an official Flutter image as the base image
FROM cirrusci/flutter:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Flutter app files into the container
COPY . /app

# Install dependencies and build the Flutter app
RUN flutter pub get
RUN flutter build web

# Expose the port the Flutter app runs on (default is 5000)
EXPOSE 5000

# Define the command to run the Flutter app
CMD ["flutter", "run", "--release"]
