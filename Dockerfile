FROM freckleiot/docker-jenkins-slave:1.0

#==============
# SBT (v1.1.4)
#==============
ENV SBT_VERSION=1.1.4
ENV SBT_HOME=/usr/local/sbt
ENV PATH=${PATH}:${SBT_HOME}/bin

RUN curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local

USER jenkins

RUN sbt sbtVersion \
    && rm -rf project

USER root

#================
# Maven (3.5.3)
#================

ENV MAVEN_VERSION=3.3.9-3

RUN apt-get update && apt-get install -y maven=$MAVEN_VERSION

#==========================
# Leiningen (Latest Stable)
#==========================
ENV LEIN_ROOT=true
RUN wget -q -O /usr/bin/lein \
        https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
        && chmod +x /usr/bin/lein
RUN lein

#=============
# Fetch caches
#=============
COPY fetch-cache /usr/local/bin/fetch-cache
RUN chmod +x /usr/local/bin/fetch-cache

ENTRYPOINT ["/usr/local/bin/entry-point", "/usr/local/bin/fetch-cache", "/usr/local/bin/jenkins-slave"]

USER root
RUN rm -rf /home/jenkins/build
