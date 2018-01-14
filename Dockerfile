FROM tomcat:8

COPY Dockerfile /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
