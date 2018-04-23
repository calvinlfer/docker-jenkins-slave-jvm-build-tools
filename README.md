# Jenkins Slave with JVM build tools
A Jenkins slave image based on freckleiot/docker-jenkins-slave with additional build tools for the JVM

This is based on `freckleiot/docker-jenkins-slave`

## Includes ##
* SBT (1.1.4)
* Maven (3.5.3)
* Node.JS (8.11.1 LTS)
* Node packages to help you deploy your code to AWS ECS (`ecs-service`)

## Building Docker images ##
To build Docker images with this slave, you must mount `/var/run/docker.sock` from your host to the same path in the container

### Permissions ###
To give the `jenkins` user in the container access to the docker.sock you must supply an environment variable:
`LOCAL_USER_GID` - Specify the GID of the `docker` group on the host. The `jenkins` user will be granted access to the `docker.sock`.

**Note:** The container must be started as root. It will then downgrade to the jenkins user with non-root privileges.
