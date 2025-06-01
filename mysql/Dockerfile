FROM mysql:8.0

# Set an insecure password
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD

# Copy over our SQL queries
COPY ./data.sql /data.sql

# Startup MySQL and run the queries
CMD ["mysqld", "--init-file=/data.sql"]