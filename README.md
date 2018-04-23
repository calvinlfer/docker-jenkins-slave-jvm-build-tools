# Jenkins Slave with JVM build tools
A Jenkins slave image based on freckleiot/docker-jenkins-slave with additional build tools for the JVM

This is based on `freckleiot/docker-jenkins-slave`

## Includes ##
* SBT (1.1.4) for Scala
* Maven (3.3.9-3) for Java
* Leiningen (latest stable) for Clojure
* Node.JS (8.11.1 LTS)
* Node packages to help you deploy your code to AWS ECS (`ecs-service`)

## Building Docker images ##
To build Docker images with this slave, you must mount `/var/run/docker.sock` from your host to the same path in the container

### Caching ###
This Docker image will fetch cached data from an S3 bucket if you provide the environment variable `CACHE_BUCKET` 
and point to an S3 bucket. 

### Permissions ###
To give the `jenkins` user in the container access to the docker.sock you must supply an environment variable:
`LOCAL_USER_GID` - Specify the GID of the `docker` group on the host. The `jenkins` user will be granted access to the `docker.sock`.

The cache.tar.gz file when unzipped should have a directory structure like so:
* `.ivy2/...`
* `.m2/...`
* ...

Your development machine contains a lot of libraries and this can be easily used as a good starting point for a cache.
Here's an example of creating a cache for SBT:
```bash
cd ~
tar -cvzf cache.tar.gz .ivy2
```

Take this `cache.tar.gz` file and upload it to the `cache` folder inside your S3 bucket.


**Note:** The container must be started as `root`. It will then downgrade to the `jenkins` user with non-root privileges.
