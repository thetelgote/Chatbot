#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token (can be set as environment variables)
USERNAME=$GITHUB_USERNAME
TOKEN=$GITHUB_TOKEN

# User and Repository information (passed as arguments to the script)
REPO_OWNER=$1
REPO_NAME=$2

# Check if both repository owner and name are provided
if [ -z "$REPO_OWNER" ] || [ -z "$REPO_NAME" ]; then
    echo "Usage: $0 <repo-owner> <repo-name>"
    exit 1
fi

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list collaborators of the repository
function list_collaborators {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
    
    # Fetch collaborators
    response=$(github_api_get "$endpoint")

    # Parse the response and list collaborator logins using grep and sed (without jq)
    echo "$response" | grep -o '"login": *"[^"]*' | sed 's/"login": "//'
}

# Function to list users with read access (you can adjust this based on specific permissions you want to check)
function list_users_with_read_access {
    echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
    
    # Endpoint for checking access (collaborators with read access)
    endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Get the collaborators
    response=$(github_api_get "$endpoint")

    # Check if any users have 'read' access, using 'permissions' field
    echo "$response" | grep -o '"login": *"[^"]*' | sed 's/"login": "//'
}

# Run the function to list collaborators
list_collaborators

# Run the function to list users with read access
list_users_with_read_access
