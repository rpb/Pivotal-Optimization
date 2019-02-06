# Pivotal-Optimization

## GPBD

## Jupyter


## Julia


**January, 2019**


### Quick-Start: Use images from dockerhub
** Quick-Start and Build instructions assume that you have docker installed and running**

1. Start Docker-Machine
```bash
    eval "$(docker-machine env default)"
```
2. Pull Images
```bash
    docker pull rpbennett/juliaopt
```
3. Run Containers
```bash

   # create network for inter container communication
   docker network create -d bridge contbridge

   # run julia image terminal
   docker run -it --rm --network=contbridge -p 8999:8999 --name=juliaopt rpbennett/juliaopt

```

4. Docker IP

```bash
# Grab IP of 'default' image
docker-machine ip default
# 192.168.99.100


### Build Docker Images

### Issues

Configuring shell session
```bash

# check docker is available
docker --version
# Docker version 1.9.1, build a34a1d5
# Docker version 1.8.0, build 0d03096
# Docker version 18.06.0-ce, build 0ffa825

docker run -it --rm -p 8888:8888 jupyter/pyspark-notebook
# Cannot connect to the Docker daemon. Is the docker daemon running on this host?

# Run this command to configure your shell:
eval "$(docker-machine env default)"

# Error checking TLS connection: default is not running. Please start it in order to use the connection settings
docker-machine rm default
docker-machine create default --driver virtualbox
# Running pre-create checks...
# Creating machine...
# (default) Creating VirtualBox VM...
# (default) Creating SSH key...
# Error attempting heartbeat call to plugin server: connection is shut down
# Error creating machine: Error in driver during machine creation: unexpected EOF

```

```bash

eval "$(docker-machine env default)"
# Error checking TLS connection: Error checking and/or regenerating the certs: There was an error validating certificates for
# host "192.168.99.100:2376": x509: certificate is valid for 192.168.99.101, not 192.168.99.100
# You can attempt to regenerate them using 'docker-machine regenerate-certs [name]'.
# Be advised that this will trigger a Docker daemon restart which might stop running containers.

docker-machine regenerate-certs default
# Regenerate TLS machine certs?  Warning: this is irreversible. (y/n): y
# Regenerating TLS certificates
# Waiting for SSH to be available...
# Detecting the provisioner...
# Copying certs to the local machine directory...
# Copying certs to the remote machine...
# Setting Docker configuration on the remote daemon...

eval "$(docker-machine env default)"
```

#### Contact

* Robert Bennett (rbennett@pivotal.io)
