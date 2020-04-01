#!/bin/bash
input="$HOME/tmp/modules/module-specification"
# Iterate over each line of the file
while IFS="" read -r line || [ -n "$line" ]
do
  set -f
  # Split the line by double colon and store result in array
  IFS=":"
  lineArray=($line)
  # Print each entry in array
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
  module=${lineArray[1]}
  version=${lineArray[2]}
  fileType=${lineArray[3]}
  # Define input and outputfile
  fileName="$module-$version.$fileType"
  outputFile="$outputFolder/$module.$fileType"

  # Download module from mavencentral using curl
  curl "https://repo1.maven.org/maven2/$folder/$module/$version/$fileName" --output "$outputFile"

done < "$input"
echo "Module download completed"