# Docker Compose Examples
Collection of docker-compose examples for different scenarios. The motivation of this project is to keep tracking of new releases and to document real-world scenarios for a production environment. Feel free to contribute with more scenarios.

# Overview

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration. [To install](https://docs.docker.com/compose/install/) follow the instructions and pre-requirements.

# Basic compose commands

> running

```
cd [folder]
docker-compose up -d
```

> monitoring

`docker-compose logs -f`

> stop

`docker-compose stop`

> clean up

```shell
docker-compose down
#clean databases and volumes
docker-compose down -v
```

# Basic Swarm commands

> running

```
cd [folder]
docker stack deploy -c docker-stack.yml <service-name>
```

> monitoring

`docker service logs -f <service-name>`

> clean up

```shell
docker stack rm <service-name>
#clean databases and volumes
docker volume prune
```
# Key features

The examples include option to create database user for the application avoiding using root user as in most of the samples. Also, create scripts that allow use `secrets` even for custom database users.


