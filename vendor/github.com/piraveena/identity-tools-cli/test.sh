#!/bin/bash

echo "Ex: "$'\e[1m'"./build.sh -t main.go -v 1.0.0 -f"$'\e[0m'" - Builds Client for version 1.0.0 for all the platforms"


echo "Cleaning build path"

echo "Setting up dependencies..."
glide install
echo