FROM tomcat
COPY target/*.war /var/lib/tomcat/webapps/
