#!/bin/bash

# ... other script logic ...

# Assuming your JSON data is stored in a variable named 'json_data'
users_with_read_access=$(jq '.users[] | select(.permissions | contains("read")) | .username' <<< "$json_data")

# Iterate over the users with read access
for user in $users_with_read_access; do
  echo "User $user has read access"
done
