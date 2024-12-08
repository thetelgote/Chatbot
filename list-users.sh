#!/bin/bash

# Directory argument (e.g., Python)
directory=$1

# Placeholder for actual logic to find users with read access
data='{
  "users": [
    {"username": "user1", "permissions": "read"},
    {"username": "user2", "permissions": "write"}
  ]
}'

# Check if there's any user with "read" access
read_access_users=$(echo "$data" | jq -e '.users[] | select(.permissions == "read")')

if [ -z "$read_access_users" ]; then
  echo "No users with read access found for $directory/"
else
  echo "$read_access_users"
fi
