#!/bin/bash
# To run this script a keycloak distribution needs to be listed in the module-specification file.
# Example: org.keycloak:keycloak-wildfly-adapter-dist:10.0.1:zip
#
# This script is required because the keycloak distribution already provides fully prepared modules.
# The keycloak modules simply need to be placed in the modules folder.
# No need to install these modules with jboss-cli.

if [ -n "$(find $HOME/tmp/modules/org -name 'keycloak-wildfly-adapter-dist-*.zip' | head -1)" ]
    then
        echo "Found keycloak adapter zip on disk."
        # Unzip keycloak adapter zip and copy modules from zip to $HOME/wildfly/modules/org/
        unzip -q $HOME/tmp/modules/org/keycloak/keycloak-wildfly-adapter-dist-*.zip -d $HOME/tmp/modules/org/keycloak
        mkdir -p $HOME/wildfly/modules/system/layers/base/org/keycloak
        cp -R $HOME/tmp/modules/org/keycloak/modules/system/add-ons/keycloak/org/keycloak/ $HOME/wildfly/modules/org/
        
        # Install each cli script from keycloak folder
        CLI_FILES=/opt/jboss/wildfly/standalone/configuration/keycloak/*.cli
        for cliFile in $CLI_FILES
        do
            echo "Executing $cliFile ..."
            # Execute each file with Jboss CLI
            /opt/jboss/wildfly/bin/jboss-cli.sh --file=$cliFile
            # Exit in case the jboss cli encountered any errors
            if [ $? -eq 1 ]; then
                exit 1
            fi
            echo "Successfully executed $cliFile"
            # Remove any entry to standalone xml history directory to avoid errors with this next line.
            # The standalone xml history is not relevant during the initial build.
            remove-standalone-xml-history.sh
        done
    else
        echo "Keycloak adapter zip does not exist on disk."
fi