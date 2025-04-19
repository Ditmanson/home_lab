FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    git \
    vim \
    tree \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /site

# Add Hugo binary
#COPY Docker/hugo-bin/hugo /usr/local/bin/hugo
COPY hugo-bin/hugo /usr/local/bin/hugo
RUN chmod +x /usr/local/bin/hugo

# Add your local Hugo site content (created outside Docker)
#COPY quickstart/ ./quickstart/
#COPY Docker/quickstart/ ./
COPY blog/ ./

# Expose port for Hugo server
EXPOSE 1313

# Run Hugo server
CMD ["hugo", "server", "-t", "paperesque", "--bind", "0.0.0.0"]
#CMD ["/bin/bash"]
