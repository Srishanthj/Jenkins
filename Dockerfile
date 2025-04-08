FROM jenkins/jenkins:2.440.1-jdk11

# Switch to root for installation
USER root

# Update package lists and install dependencies
RUN apt-get update && apt-get install -y \
    lsb-release \
    python3-pip \
    curl \
    gnupg

# Add Docker’s official GPG key
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg

# Add Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Update package lists again and install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"

# Switch back to Jenkins user for security
USER jenkins

#cca24955813846e3b0e0e64c87913645