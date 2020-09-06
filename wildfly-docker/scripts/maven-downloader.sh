#!/bin/bash
while getopts "g:a:v:p:o:" opt;
do
    case ${opt} in
    g) 
        GROUP=$OPTARG
        ;;
    a) 
        ARTIFACT=$OPTARG
        ;;
    v)
        VERSION=$OPTARG
        ;;
    p)
        PACKAGE=$OPTARG # Package can be either jar, war, ear or zip
        ;;
    o)
        OUTPUT=$OPTARG
        ;;
    esac
done

# Guard to prevent empty group
if [ -z ${GROUP+x} ]
    then
    echo "Group was not provided!"
    exit 1
fi

# Guard to prevent empty artifact
if [ -z ${ARTIFACT+x} ]
    then
    echo "Artifact was not provided!"
    exit 1
fi

# Guard to prevent empty version
if [ -z ${VERSION+x} ]
    then
    echo "Version was not provided!"
    exit 1
fi

# Guard to prevent empty Type definition
if [ -z ${PACKAGE+x} ]
    then
    echo "Package was not provided!"
    exit 1
fi

# Guard to prevent empty output definition
if [ -z ${OUTPUT+x} ]
    then
    echo "Output was not provided!"
    exit 1
fi

REPOSITORY_URL="https://repo1.maven.org/maven2"
GROUP_PATH=${GROUP//"."/"/"}
FILE_NAME="$ARTIFACT-$VERSION.$PACKAGE"

# Check if version is a snaphsot release. 
# Those are sometimes stored in different repositories
if [[ $VERSION == *"-SNAPSHOT"* ]]; then
  echo "I'm a Snapshot Release!"
  # REPOSITORY_URL="Snapshot-URL"
fi

# Download maven artifact from mavencentral using curl
echo "Downloading $GROUP:$ARTIFACT:$VERSION:$PACKAGE from $REPOSITORY_URL"
curl --fail -s "$REPOSITORY_URL/$GROUP_PATH/$ARTIFACT/$VERSION/$FILE_NAME" --output "$OUTPUT"