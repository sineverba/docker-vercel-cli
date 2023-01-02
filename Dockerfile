FROM node:18.12.1-alpine3.16

RUN apk update && apk upgrade

ENV NPM_VERSION 9.2.0
ENV CLI_VERSION 28.10.1

RUN npm install -g npm@${NPM_VERSION} && npm install -g vercel@${CLI_VERSION}