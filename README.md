# GitHub Action for Creating and Publishing a Docker Image

This repository contains code and instructions on how to use a GitHub action to build and publish a docker image.


## Creating your first workflow which creates a Docker Image

This example illustrates how to setup your first workflow. It uses the code in this repository, and can be run in the repo as a test or as a fallback to see how the code works.

We suppose that you have an application that can be build and distributed using a Docker Image. If you want to know more about creating a Dockerfile and building a Docker Image, check out the documentation in [https://docs.docker.com/](https://docs.docker.com/).

Note the following files and folders in the application:

* dockerfile: the dockerfile configured for building and running this application. 
* requirements.txt: the file that specified the libraries to be used by the application. It is used in the dockerfile.
* hello_world_app: the django folder that contains the code for the web application.

If you run this docker image, you 


The following steps will be performed:

* Create a workflow that will package the application in a Docker Image, which will be hosted on ghrc.io.
* Run the workflow.
* Create a docker-compose.yml file that uses the Docker Image.
* Logon to ghcr.io
* Run the docker-compose.yml file.


### Creating the workflow

In your repository, create a file called `.github\workflows\create-docker-image.yml`.

Copy the following code into this file:

```
name: Create Docker Image for <Name Of Application>

on: 
  workflow_dispatch:
  
env:
  IMAGE_NAME: 'ghcr.io/flanders-make-vzw/<Name Of Application Image>'

jobs:

  build:

    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2

    - name: Login to Github Packages
      uses: docker/login-action@v3
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
        tags:
          ${{ env.IMAGE_NAME }}:latest, ${{ env.IMAGE_NAME }}:1.0.0
        labels:
          ${{ env.IMAGE_NAME }}:1.0.0
```

Replace the following:

* \<Name Of Application> : This is part of the label for the build that will be shown when running the workflow.
* \<Name Of Application Image>: This should be the name of the Docker Image. It will be shown in GitHub Packages and will be used in the docker-compose.yml.





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


