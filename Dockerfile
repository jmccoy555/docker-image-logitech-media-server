FROM ubuntu:bionic
MAINTAINER Lars Kellogg-Stedman <lars@oddbit.com>

ENV SQUEEZE_VOL /srv/squeezebox
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV MEDIASERVER_URL=http://downloads-origin.slimdevices.com/nightly/7.9/sc/3a9b73970ee27f84ce2cf7f7cbc8341635eba2b3/logitechmediaserver_7.9.2~1537165800_amd64.deb

RUN apt-get update && \
	apt-get -y --force-yes install curl wget faad flac lame sox libio-socket-ssl-perl ffmpeg && \
	curl -Lsf -o /tmp/logitechmediaserver.deb $MEDIASERVER_URL && \
	dpkg -i /tmp/logitechmediaserver.deb && \
	rm -f /tmp/logitechmediaserver.deb && \
	apt-get clean

VOLUME $SQUEEZE_VOL
EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh
ENTRYPOINT ["/entrypoint.sh"]