#!/bin/bash
# Fetch a list of all .cli files that were placed in the configuration/cli folder
FILES=/opt/jboss/wildfly/standalone/configuration/cli/*.cli
for cliFile in $FILES
do
  # Check if file exists
  if [ -f "$cliFile" ]; then
    echo "Executing $cliFile ..."
    # Execute each file with Jboss CLI
    /opt/jboss/wildfly/bin/jboss-cli.sh --file=$cliFile
  fi
done