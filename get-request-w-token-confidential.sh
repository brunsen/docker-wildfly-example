#!/bin/bash

CLIENT_ID=tour-of-heroes
CLIENT_SECRET=e21ba281-cd10-4653-a03a-140f2f3f6a68
REALM=develop
AUTHENTICATION_URL=http://keycloak:8080/auth/realms/$REALM/protocol/openid-connect/token

# Authentication=$(echo "$CLIENT_ID:$CLIENT_SECRET" | base64 -b 0) # -b Ist auf Mac OS nötig
Authentication=dG91ci1vZi1oZXJvZXM6OGNkMTFlMDYtODYyMi00ZTMyLTg0ZGYtNmMxZmQyMGUzYTc2
echo "authentication: $Authentication"

# echo "authentication decoded:"
# echo $Authentication | base64 --decode


# -d "client_id=$CLIENT_ID" \
# -d "client_secret=$CLIENT_SECRET" \

ACCESS_TOKEN=$(curl \
-X POST \
-H "Authorization: Basic $Authentication" \
-d "username=bennet" \
-d "password=bennet" \
-d "client_id=$CLIENT_ID" \
-d "grant_type=password" \
-d "client_secret=$CLIENT_SECRET" \
$AUTHENTICATION_URL | jq -r '.access_token')
   
echo "Bearer Token received!"
echo "$ACCESS_TOKEN"

RESOURCE=test

curl -k -X GET "http://localhost:8180/tour-of-heroes-backend/api/$RESOURCE" -H "Authorization: Bearer $ACCESS_TOKEN" -v
echo
