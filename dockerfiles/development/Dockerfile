FROM node:20.10.0-alpine3.19
# Set versions
ENV NPM_VERSION=10.2.5
ENV VERCEL_CLI_VERSION=32.7.2
# Update and upgrade
RUN apk update && \
    apk add --upgrade apk-tools git openssh-client && \
    apk upgrade --available && \
    rm -rf /var/cache/apk/*
# Install
RUN npm install -g npm@${NPM_VERSION} && \
    npm install -g vercel@${VERCEL_CLI_VERSION}
# Use non root user
USER node