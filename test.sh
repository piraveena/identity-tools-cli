#!/bin/bash

echo "Builds Client for version 1.0.0 for all the platforms"

ENV GOPATH /build/software/go/go
ENV PATH $GOPATH/bin:/build/software/go/go-1.12.5/bin:$PATH
RUN mkdir -p "$GOPATH/src/github.com/wso2" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN curl https://glide.sh/get | sh

echo "Cleaning build path"

echo "Setting up dependencies..."
glide install
echo