#!/bin/bash
input="$HOME/tmp/deployments/deployment-list"
# Iterate over each line of the file
while IFS="" read -r line || [ -n "$line" ]
do
  # Split the line by double colon and store result in array
  IFS=":"
  read -ra lineArray <<< "$line"
  # Parse deployment information
  group=${lineArray[0]}
  artifact=${lineArray[1]}
  version=${lineArray[2]}
  fileType=${lineArray[3]}
  # Define outputfile
  outputFile="opt/jboss/wildfly/standalone/deployments/$artifact-$version.$fileType"
  # Call maven downloader to actually download the artifact
  maven-downloader.sh -g $group -a $artifact -v $version -t $fileType -o $outputFile
  
  # Exit in case the maven downloader encountered any errors
  if [ $? -eq 1 ]; then
    echo "Failed to download $group:$artifact:$version:$fileType from maven"
    exit 1
  fi

done < "$input"
echo "Deployment download completed"
# TODO Keep downloaded specification somewhere
# Copy deployment file to different folder in case used module versions need to be looked up.
cp $HOME/tmp/deployments/deployment-list /opt/jboss/wildfly/standalone/configuration/downloaded-deployments