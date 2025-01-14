# GitHub Action for Creating and Publishing a Docker Image

This repository contains code and instructions on how to use a GitHub action to build and publish a docker image. This image contains a Hello World Django example.

## Create the build yaml file

In your repository, create a file called `.github\workflows\create-docker-image.yml`.

Copy the following code into this file:


```
name: Create Docker Image for GitHub Action Cookbook

on: 
  workflow_dispatch:
        
  # repository_dispatch:
  #   types: build-ceros-palletizing-api

env:
  IMAGE_NAME: 'ghcr.io/flanders-make-vzw/github-action-cookbook'

jobs:

  build:

    runs-on: ubuntu-latest
    permissions:
      contents: write # Needed to increment version number, and tag.
      packages: write
      deployments: write

    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      with:
        submodules: 'recursive'
        token : ${{ secrets.PAT_TOKEN }}
      
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2

    - name: Login to Github Packages
      uses: docker/login-action@v1
      with:
        registry: ghcr.io
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN  }}
      
    - name: Build and push
      uses: docker/build-push-action@v3
      with:
        context: .
        platforms: linux/amd64
        push: true
```

Save this file, and push it to the repository.


