FROM mysql:8

COPY ./init_ddl.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init_ddl.sh