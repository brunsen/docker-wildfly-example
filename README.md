# docker wildfly example
 
This project serves as a showcase on automatically setting up a wildfly application server within a docker container. The automation is achieved by simply using some bash scripts that are executed when the docker image is build. There is no need for third party tools such as maven or gradle.

To run this project open any console, navigate to the docker-compose file and type "docker-compose up"

After running the docker-compose.yaml you will find a mariadb database fully setup and a wildfly application server that is able to connect to the database.

For further instuctions on how to adapt this project to your needs refer to the READ.me files in the subfolders of this project.