FROM openjdk:8

MAINTAINER linshare <linshare@linagora.com>

EXPOSE 8080
EXPOSE 8081

ARG VERSION="2.0.4"
ARG CHANNEL="releases"
ARG EXT="com"

ENV LINSHARE_VERSION=$VERSION

WORKDIR /usr/local/sbin/
RUN mkdir -p /etc/linshare-thumbnail-server /srv/linshare-tmp
VOLUME /srv/linshare-tmp
COPY config.yml /etc/linshare-thumbnail-server/

RUN apt-get update && apt-get install -y curl libreoffice && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV URL="https://nexus.linagora.${EXT}/service/local/artifact/maven/content?r=linshare-${CHANNEL}&g=org.linagora.linshare&a=thumbnail-server&v=${VERSION}"
RUN curl -k -s "${URL}&p=jar" -o linshare-thumbnail-server.jar && curl -k -s "${URL}&p=jar.sha1" -o linshare-thumbnail-server.jar.sha1 \
  && sed -i 's#^\(.*\)#\1\tlinshare-thumbnail-server.jar#' linshare-thumbnail-server.jar.sha1 \
  && sha1sum -c linshare-thumbnail-server.jar.sha1 --quiet && rm -f linshare-thumbnail-server.jar.sha1

ENTRYPOINT ["java", "-jar", "-Djava.io.tmpdir=/srv/linshare-tmp", "/usr/local/sbin/linshare-thumbnail-server.jar", "server", "/etc/linshare-thumbnail-server/config.yml"]
