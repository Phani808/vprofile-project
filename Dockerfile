FROM tomcat:8-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8081
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps


FROM mysql:5.7.25
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

ENV MYSQL_ROOT_PASSWORD="vprodbpass"
ENV MYSQL_DATABASE="accounts"


ADD db_backup.sql docker-entrypoint-initdb.d/db_backup.sql


FROM nginx
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /etc/nginx/conf.d/default.conf
COPY nginvproapp.conf /etc/nginx/conf.d/vproapp.conf

