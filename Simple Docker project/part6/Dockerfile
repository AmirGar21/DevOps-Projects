FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R nginx:nginx /var/cache/nginx && \
    mkdir -p /var/run && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid && \
    mkdir -p /var/log/nginx && \
    touch /var/log/nginx/access.log && \
    chown nginx:nginx /var/log/nginx/access.log


USER nginx