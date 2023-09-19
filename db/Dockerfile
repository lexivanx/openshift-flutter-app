# Use an official PostgreSQL as the base image
FROM postgres:latest

# Set environment variables (customize as needed)
ENV POSTGRES_DB=my_database
ENV POSTGRES_USER=my_user
ENV POSTGRES_PASSWORD=my_password

# Copy the database initialization script to the container
COPY init.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432

# Define the command to run the PostgreSQL container
CMD ["postgres"]
