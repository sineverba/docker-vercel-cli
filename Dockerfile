FROM node:16.12.0-alpine3.14

RUN apk update && apk upgrade

ENV CLI_VERSION 23.1.2

RUN npm install -g vercel@${CLI_VERSION}