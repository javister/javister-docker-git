FROM javister-docker-docker.bintray.io/javister/javister-docker-base:1.0
MAINTAINER Viktor Verbitsky <vektory79@gmail.com>

LABEL image.date="${DATE}"

COPY files /

ENV HOME="/app" \
    LOG_LEVEL="INFO" \
    RPMLIST="git" \
    SET_GIT_PROXY="no"

RUN . /usr/local/bin/yum-proxy && \
    yum-install && \
    yum-clean && \
    chmod --recursive --changes +x /etc/my_init.d/*.sh /etc/service /usr/local/bin

ENTRYPOINT ["my_init", "--skip-runit", "--", "git-docker"]
CMD ["--version"]
