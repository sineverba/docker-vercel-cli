FROM node:18.16.1-alpine3.18
# Set versions
ENV NPM_VERSION 9.8.0
ENV VERCEL_CLI_VERSION 31.0.3
# Update and upgrade
RUN apk update --no-cache && apk upgrade
# Install
RUN npm install -g npm@${NPM_VERSION} && npm install -g vercel@${VERCEL_CLI_VERSION}
# Test against versions
RUN node -v | grep 18.16.1
RUN npm -v | grep ${NPM_VERSION}
RUN vercel -v | grep ${VERCEL_CLI_VERSION}