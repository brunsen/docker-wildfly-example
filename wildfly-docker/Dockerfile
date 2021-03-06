FROM jboss/wildfly:21.0.0.Final
USER root
# Add cli scripts to image
ADD cli /opt/jboss/wildfly/standalone/configuration/cli
ADD scripts /usr/local/bin
RUN chmod -v a+x /usr/local/bin/*
# Change back to jboss user since the following operatios require less permissions
USER jboss
# Create temporary directory to copy for example module specifications
RUN mkdir tmp
ADD --chown=jboss:jboss modules tmp/modules
ADD --chown=jboss:jboss deployments tmp/deployments
# Execute module downloader script
RUN module-downloader.sh
# Execute script to process cli files with jboss-cli
RUN read_cli.sh
# Configure datasources
ADD --chown=jboss:jboss datasources /opt/jboss/wildfly/standalone/configuration/datasources
RUN configure-datasources.sh
# Install keycloak adapter
ADD --chown=jboss:jboss keycloak /opt/jboss/wildfly/standalone/configuration/keycloak
RUN install-keycloak-adapter.sh
# Execute deployment downloader script
RUN deployment-downloader.sh
# Remove temporary directory. It's no longer required at this point
RUN rm -rf tmp
# Add at least admin user to get acces to wildfly console. Could be changed to another user
RUN /opt/jboss/wildfly/bin/add-user.sh admin nimda --silent
EXPOSE 9990
ENTRYPOINT ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]