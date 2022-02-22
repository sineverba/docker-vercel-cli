FROM node:16.14.0-alpine3.15

RUN apk update && apk upgrade

ENV NPM_VERSION 8.5.1
ENV CLI_VERSION 24.0.0

RUN npm install -g npm@${NPM_VERSION} && npm install -g vercel@${CLI_VERSION}