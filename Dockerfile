FROM redhat/ubi10-minimal

# Install the application dependencies
RUN microdnf update -y
RUN microdnf install yum-utils httpd httpd-tools -y
RUN microdnf install php php-cli php-common php-fpm php-gd php-curl php-zip php-mbstring php-mysqlnd -y

# USER apache
#
# ENV DB_USER=$DB_USER
# ENV DB_PASS=$DB_PASS
#
# USER root

# Copy in the source code
RUN mkdir /deployments
COPY src /var/www/html
COPY bin /deployments

# Server changes
RUN echo 'ServerName 127.0.0.1' >> /etc/httpd/conf/httpd.conf
RUN mkdir -p /run/php-fpm/
RUN chmod 777 -R /deployments

WORKDIR /deployments

EXPOSE 80

CMD ["sh","startup.sh"]