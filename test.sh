#!/bin/bash

echo "Builds Client for version 1.0.0 for all the platforms"
echo "Cleaning build path"

REPO_URL="https://glide.sh/get"
status=$(curl --head --silent ${REPO_URL} | head -n 1)

echo ${status}
echo 'No previous versions for the components exists'


echo "*****"
glide install
echo "Setting up dependencies..."
