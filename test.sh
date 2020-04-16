#!/bin/bash

echo "Builds Client for version 1.0.0 for all the platforms"
echo "Cleaning build path"
curl https://glide.sh/get | sh
glide install
echo "Setting up dependencies..."
