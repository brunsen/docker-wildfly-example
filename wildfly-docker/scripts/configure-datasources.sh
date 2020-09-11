#!/bin/bash
# Fetch a list of all .properties files that were placed in the configuration/datasources folder
FILES=/opt/jboss/wildfly/standalone/configuration/datasources/*.properties
cliFile=/opt/jboss/wildfly/standalone/configuration/datasources/add_datasource.cli
for datasource in $FILES
do
  # Check if file exists
  if [ -f "$datasource" ]; then
    echo "About to configure $datasource ..."
    # Execute each file with Jboss CLI
    /opt/jboss/wildfly/bin/jboss-cli.sh --file=$cliFile --properties=$datasource
    # Exit in case the jboss cli encountered any errors
    if [ $? -eq 1 ]; then
      exit 1
      else 
        echo "Configured $datasource"
    fi
    # Remove any entry to standalone xml history directory to avoid errors with this next line.
    # The standalone xml history is not relevant during the initial build.
    remove-standalone-xml-history.sh
  fi
done