# syntax=docker/dockerfile:1
FROM ubuntu:latest
RUN apt-get -y update && \
    apt-get install -y build-essential make cmake ninja-build wget tar xzip unzip vim git && \
    apt-get clean