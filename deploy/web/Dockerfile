FROM nginx:latest

# COPY deploy/web/nginx.conf /etc/nginx/nginx.conf
# COPY deploy/web/server.conf /etc/nginx/conf.d/server.conf
COPY app_src/src/main/resources/static/resources/css /usr/share/nginx/html/css
COPY app_src/src/main/resources/static/resources/fonts /usr/share/nginx/html/fonts
COPY app_src/src/main/resources/static/resources/images /usr/share/nginx/html/images

