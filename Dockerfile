FROM alpine:3.4

MAINTAINER Wessel Pieterse

RUN apk add --update nginx git
RUN mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/
RUN mkdir -p /usr/share/nginx/html &&\
    git clone https://github.com/centular/swagger-ui /tmp/swagger-ui &&\
    mv /tmp/swagger-ui/dist/* /usr/share/nginx/html/  &&\
    rm /tmp/swagger-ui -R

EXPOSE 8080

CMD exec nginx -g 'daemon off;'