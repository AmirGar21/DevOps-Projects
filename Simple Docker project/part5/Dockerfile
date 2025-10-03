FROM debian:latest

RUN apt-get update && apt-get install -y gcc spawn-fcgi libfcgi-dev nginx && rm -rf /var/lib/apt/lists/*
RUN useradd -m user

WORKDIR /server 

COPY server.c .
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN gcc -o server server.c -lfcgi
RUN chmod +x /entrypoint.sh

RUN mkdir -p /var/lib/nginx/body && \
    chown -R user:user /var/lib/nginx && \
    chown user:user /etc/nginx/nginx.conf && \
    mkdir -p /var/cache/nginx/client_temp && \
    chown -R user:user /var/cache/nginx && \
    mkdir -p /var/run && \
    touch /var/run/nginx.pid && \
    chown user:user /var/run/nginx.pid && \
    mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    chown user:user /var/log/nginx/access.log



USER user

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:8080 || exit 1


ENTRYPOINT ["/entrypoint.sh"]