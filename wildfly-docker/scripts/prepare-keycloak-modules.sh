#!/bin/bash
# To run this script a keycloak distribution needs to be listed in the module-specification file.
# Example: org.keycloak:keycloak-wildfly-adapter-dist:10.0.1:zip
#
# This script is required because the keycloak distribution already provides fully prepared modules.
# The keycloak modules simply need to be placed in the modules folder.
# No need to install these modules with jboss-cli.
unzip $HOME/tmp/modules/org/keycloak/keycloak-wildfly-adapter-dist-*.zip -d $HOME/tmp/modules/org/keycloak

mkdir -p $HOME/wildfly/modules/system/layers/base/org/keycloak
cp -R $HOME/tmp/modules/org/keycloak/modules/system/add-ons/keycloak/org/ $HOME/wildfly/modules/org/