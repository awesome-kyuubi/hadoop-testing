FROM bitnami/mysql:8.0

COPY ./files /

ENV MYSQL_ROOT_PASSWORD=root \
    MYSQL_AUTHENTICATION_PLUGIN=mysql_native_password \
    MYSQL_DATABASE=metastore
