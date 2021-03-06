#!/bin/bash
input="$HOME/tmp/modules/module-specification"
touch "$HOME/tmp/modules/modules.properties"
propertiesFile="$HOME/tmp/modules/modules.properties"
# Iterate over each line of the file
while IFS="" read -r line || [ -n "$line" ]
do
  # Split the line by double colon and store result in array
  IFS=":"
  read -ra lineArray <<< "$line"
  # Detect required folder name
  folder="${lineArray[0]}"
  # Replace . with /
  folder=${folder//"."/"/"}
  outputFolder="$HOME/tmp/modules/$folder"
  if [[ ! -d "$outputFolder" ]]
  then
    echo "$outputFolder does not exist on your filesystem. Will create folder now."
    # Create folder including parent folders
    mkdir -p "$outputFolder"
  fi
  # Parse module information
  group=${lineArray[0]}
  artifact=${lineArray[1]}
  version=${lineArray[2]}
  fileType=${lineArray[3]}
  # Define outputfile
  outputFile="$outputFolder/$artifact-$version.$fileType"
  # Call maven downloader to actually download the artifact
  maven-downloader.sh -g $group -a $artifact -v $version -p $fileType -o $outputFile
  # Exit in case the maven downloader encountered any errors
  if [ $? -eq 1 ] 
  then
    echo "Failed to download $group:$artifact:$version:$fileType from maven"
    exit 1
  else
    echo "Successfully downloaded $group:$artifact:$version:$fileType stored in $outputFile"
    echo -e "$group.$artifact.location=$outputFile" >> $propertiesFile
  fi

done < "$input"
echo "Modules download completed"