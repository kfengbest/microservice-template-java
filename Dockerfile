FROM tomcat:8

COPY ./target/microservice-template-java.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
