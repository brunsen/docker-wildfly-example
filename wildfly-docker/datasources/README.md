To specify which datasources are required for your wildfly configuration, place as many properties files as you need in this folder. The setup will iterate over each property file with the suffix ".properties" and configure the datasource accordingly. The content of each property file needs to be structured like typical properties files. The properties files need to have at least values for:
    - datasource.name
    - datasource.connection.url
    - datasource.user.name
    - datasource.user.password
    - datasource.driver
Other values may be provided, but will have defaults.

Example:
datasource.name=heroesDS
datasource.connection.url=${env.DATABASE_CONNECTION_URL}
datasource.user.name=${env.DATABASE_USER}
datasource.user.password=${env.DATABASE_PASSWORD}
datasource.driver=${env.DATABASE_JDBC_DRIVER}