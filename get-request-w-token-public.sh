#!/bin/bash
REALM=develop
AUTHENTICATION_URL=http://keycloak:8080/auth/realms/$REALM/protocol/openid-connect/token
ACCESS_TOKEN=$(curl \
-X POST \
-d "client_id=tour-of-heroes" \
-d "username=bennet" \
-d "password=bennet" \
-d "grant_type=password" \
$AUTHENTICATION_URL | jq -r '.access_token')
   
echo "Bearer Token received!"
echo $ACCESS_TOKEN

curl -k -X GET "http://localhost:8180/tour-of-heroes-backend/api/heroes" -H "Authorization: Bearer $ACCESS_TOKEN" -v
echo