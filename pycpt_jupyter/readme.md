# PyCPT Jupyter Image
This repository contains all resources needed to execute analysis using PyCPT with Jupyter. 
The models which are inside this repository are:

* CPT - Climate Predictable Tool

## Repository
This repository is composed of a set of folders that have specific functions. The following list
describes each directory:

### models
This folder has the climate models. 
You will find this folder inside the container in the path: **/forecast/models**.

### versions
It has all versions of the image Docker with all resources for that version.

## How to use
The following section explains a couple of things that you should take into account when you
are trying to run the image.

### Install
The installation process requires that the **Docker** system is installed. Once you have installed
the Docker you just need to execute the following command, which downloads the image from the Docker hub:

``` bash
docker pull stevensotelo/pycpt_jupyter:latest
```

### Run
This image has a folder in which you can share files between the host and the docker container. The folder
is **work** (located in /home/jovyan/work into the container). You should connect a folder from your PC with this volume in the
image. The following command describes how to execute an instance of the image like a Docker container, further
it connects a local folder (D:/my_folder/workdir) with the volume in the docker (/home/jovyan/work).

``` bash
docker run --name pycpt -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v D:/my_folder/workdir:/home/jovyan/work -d stevensotelo/pycpt_jupyter:latest
```

The first time you interact with jupyter in the web browser, it will ask for a token. You can see the token executing the
following command in the cmd

``` bash
docker logs pycpt
```

## KEY NOTE
You should run everything into jupyter notebook with the kernel **envpycpt**, otherwise the package won't be available

# VERSIONS


