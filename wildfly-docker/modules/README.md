Specify which artifact you need downloaded to be processed later by cli scripts in the module-specification file.
To specify an artifact, use the gradle like syntax with double colons as delimiters.
<group>:<artifact>:<version>:<type>
You can specify more than one artifact to be downloaded. 
Each artifact needs to be in its own line, since the module downloader script will process each line and try to parse the required information

Examples:
org.mariadb.jdbc:mariadb-java-client:2.6.0:jar
org.hibernate:hibernate-core:5.4.14.Final:jar