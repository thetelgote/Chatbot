#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token from environment variables
USERNAME=$GITHUB_USERNAME
TOKEN=$GITHUB_TOKEN

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
    # Send GET request to fetch collaborators and filter those with read access
    response=$(github_api_get "$endpoint")

    # Parse the response and filter users with read access (You may need jq for this step)
    echo "$response" | jq '.[] | select(.permissions.pull == true) | .login'
}

# Run the function with the provided arguments
list_users_with_read_access
