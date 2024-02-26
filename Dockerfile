# Use an official Python runtime as the base image
FROM python:3.9

# Set the author of the image
MAINTAINER John Doe <john.doe@example.com>

# Set build-time argument (allows flexibility in specifying image versions during build)
ARG VERSION=latest

# Set environment variables (for setting paths, configuring services, etc.)
ENV APP_HOME /app  # Application directory
ENV PORT 8080       # Port on which the application will listen

# Set the working directory in the container
WORKDIR $APP_HOME

# Copy requirements.txt to the working directory (for Python dependencies)
COPY requirements.txt .

# Install dependencies (using pip to install Python packages listed in requirements.txt)
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code (copy the application source code into the container)
COPY . .

# Expose port 8080 to the outside world (make the port accessible externally)
EXPOSE $PORT

# Specify the default command to run when the container starts (starting the Python application)
CMD ["python", "app.py"]

# Add metadata to the image (descriptive information about the image)
LABEL version="1.0"  # Version of the image
LABEL description="Example Dockerfile with all commands"  # Description of the image
LABEL maintainer="John Doe <john.doe@example.com>"         # Maintainer of the image

# Create a volume (create a mount point for external data)
VOLUME /var/lib/mysql

# Define a health check (check the health of the container and its applications)
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

# Multi-line RUN command (run multiple commands in a single RUN instruction)
RUN apt-get update && \
    apt-get install -y \
        package1 \
        package2 \
        package3

# Override default shell (change the default shell used for executing commands)
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Stop signal (set the system call signal to be sent to the container to exit)
STOPSIGNAL SIGTERM

# On-build trigger (add instructions to be executed when another image uses this image as its base)
ONBUILD COPY . /app
ONBUILD RUN make /app
