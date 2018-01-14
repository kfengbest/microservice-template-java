FROM tomcat:8

COPY Dockerfile /usr/local/tomcat/webapps/

CMD ["sh", "ls -la"]

COPY ./artifect.zip /usr/local/tomcat/webapps/
COPY ./microservice-template-java.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
