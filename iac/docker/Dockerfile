# IAC scanner testing fixtures - Dockerfile with known misconfigurations

# CKV_DOCKER_2 - No HEALTHCHECK defined
# CKV_DOCKER_3 - Running as root (no USER instruction)
FROM ubuntu:20.04

# CKV_DOCKER_1 - Using ADD instead of COPY for non-archive files
ADD https://example.com/app.tar.gz /app/

# CKV_DOCKER_4 - Using sudo
RUN apt-get update && \
    apt-get install -y sudo curl wget && \
    sudo chmod 777 /tmp

# CKV_DOCKER_7 - Using latest tag
FROM node:latest

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

# Hardcoded secret in ENV (also triggers secrets scanner)
ENV DATABASE_PASSWORD=SuperSecret123!
ENV API_KEY=sk-1234567890abcdef1234567890abcdef

EXPOSE 3000 22

CMD ["node", "server.js"]
