FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    net-tools \
    openjdk-11-jre-headless

# Set up working directory
WORKDIR /app

# Download and install Ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip

# Authenticate Ngrok
ARG NGROK_AUTH_TOKEN
RUN ./ngrok authtoken "2hG3JO6ZSoh5oXGl6UQtT4reVIG_56itJ1VjUoaWkBA4C8wAa"

# Install xrdp and xfce4 for RDP
RUN apt-get install -y xrdp xfce4

# Expose RDP port
EXPOSE 3389

# Start Ngrok tunnel for RDP
CMD ["./ngrok", "tcp", "3389"]
