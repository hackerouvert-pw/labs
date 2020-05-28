# Docker files for lab

This repository contains files to spin-up quick and simple CTF labs with some
basic tools. They are not fully complete and they especially aimed at helping
students who do not have Linux or a lot of space to install tools. Those dockers
can run on a simple 2Go server.

## Run

**Change the passwords in the `docker-compose.yml` file for your users.**

```sh
docker-compose build
docker-compose up # use -d to run it in the background
```

## Connect

```sh
ssh alice@your_ip -P 9001
```
