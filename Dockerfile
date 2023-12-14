ARG NODE_VERSION=20.10.0
FROM node:${NODE_VERSION}-alpine3.19
# Set versions
ARG NPM_VERSION=10.2.5
ARG VERCEL_CLI_VERSION=32.7.2
# Update and upgrade
RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available && \
    rm -rf /var/cache/apk/*
# Install
RUN npm install -g npm@${NPM_VERSION} && \
    npm install -g vercel@${VERCEL_CLI_VERSION}
