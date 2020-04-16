#!/bin/bash

echo "Builds Client for version 1.0.0 for all the platforms"
echo "Cleaning build path"

url=https://temptemp3.github.io

curl ${url}

echo "*****"
glide install
echo "Setting up dependencies..."
