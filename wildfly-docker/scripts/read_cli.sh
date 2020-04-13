#!/bin/bash
# Fetch a list of all .cli files that were placed in the configuration/cli folder
FILES=/opt/jboss/wildfly/standalone/configuration/cli/*.cli
for cliFile in $FILES
do
  # Check if file exists
  if [ -f "$cliFile" ]; then
    echo "Executing $cliFile ..."
    # Execute each file with Jboss CLI
    /opt/jboss/wildfly/bin/jboss-cli.sh --file=$cliFile --properties=$HOME/tmp/modules/modules.properties
    # Exit in case the jboss cli encountered any errors
    if [ $? -eq 1 ]; then
      exit 1
    fi
  fi
done