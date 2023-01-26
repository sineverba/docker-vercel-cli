FROM node:18.13.0-alpine3.17
# Set versions
ENV NPM_VERSION 9.4.0
ENV VERCEL_CLI_VERSION 28.13.1
# Update and upgrade
RUN apk update --no-cache && apk upgrade
# Install
RUN npm install -g npm@${NPM_VERSION} && npm install -g vercel@${VERCEL_CLI_VERSION}
# Test against versions
RUN node -v | grep 18.13.0
RUN npm -v | grep ${NPM_VERSION}
RUN vercel -v | grep ${VERCEL_CLI_VERSION}