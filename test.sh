#!/bin/bash

echo "Builds Client for version 1.0.0 for all the platforms"
echo "Cleaning build path"

url="https://glide.sh/get"

curl ${url}

echo "*****"
glide install
echo "Setting up dependencies..."
