FROM debian:latest

RUN apt-get update && apt-get install -y gcc spawn-fcgi libfcgi-dev nginx 

WORKDIR /server 

COPY server.c .
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN gcc -o server server.c -lfcgi
RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]