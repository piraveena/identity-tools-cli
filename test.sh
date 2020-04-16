#!/bin/bash

echo "Builds Client for version 1.0.0 for all the platforms"
echo "Cleaning build path"

echo 'No previous versions for the components exists'


echo "*****"
glide install
echo "Setting up dependencies..."
