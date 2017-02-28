FROM node:0.10

MAINTAINER Wessel Pieterse <wessel<at>ordercloud<dot>com>


RUN apt-get install git -y

RUN npm update npm &&\
    npm install http-server replace


RUN mkdir -p /swaggerui/dist && git clone https://github.com/centular/swagger-ui/dist

ENV API_URL http://petstore.swagger.io/v2/swagger.json

RUN echo "'use strict';\
var path = require('path');\
var createServer = require('http-server').createServer;\
var dist = path.join('swaggerui', 'dist');\
var replace = require('replace');\
replace({regex: 'http.*swagger.json', replacement : process.env.API_URL, paths: ['/swaggerui/dist/swagger-ui/index.html'], recursive:false, silent:true,});\
var swaggerUI = createServer({ root: dist, cors: true });\
swaggerUI.listen(8888);" > /swaggerui/index.js

EXPOSE 8888
CMD ["node", "/swaggerui/index.js"]