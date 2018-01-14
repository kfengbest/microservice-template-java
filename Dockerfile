FROM tomcat:8

COPY microservice-template-java.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
