# create dev database, similar to production db
create database if not exists herodb;
USE herodb;

# create user that shall have access to the databases
create user 'hero' identified by 'heropw';

# grant all rights to db user
grant usage on *.* to 'hero';
grant all privileges on herodb.* to 'hero';

# flush privileges so that the user will gain read/write access
flush privileges;