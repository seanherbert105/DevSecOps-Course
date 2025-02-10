FROM docker.io/tomcat:9-jdk11

# Set environment variables
ENV GEOSERVER_VERSION=2.22.2 \
    GEOSERVER_HOME=/opt/geoserver \
    CATALINA_HOME=/usr/local/tomcat

# Download and install GeoServer
RUN apt-get update && apt-get install -y wget unzip && \
    wget -O /tmp/geoserver.zip \
    https://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-bin.zip/download && \
    mkdir -p $GEOSERVER_HOME && \
    unzip /tmp/geoserver.zip -d /tmp && \
    mv /tmp/geoserver-${GEOSERVER_VERSION}/* $GEOSERVER_HOME/ && \
    rm -rf /tmp/geoserver.zip /tmp/geoserver-${GEOSERVER_VERSION} && \
    apt-get remove -y wget unzip && apt-get autoremove -y && apt-get clean

# Move GeoServer to Tomcat webapps directory
RUN mv $GEOSERVER_HOME/webapps/geoserver.war $CATALINA_HOME/webapps/

# Expose GeoServer default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
