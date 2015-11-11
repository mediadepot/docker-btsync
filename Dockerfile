FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Install base applications + deps
RUN apt-get -q update && \
    apt-get install -qy --force-yes python-cheetah && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create btsync folder structure & set as volumes
RUN mkdir -p /srv/btsync/config && \
	mkdir -p /srv/btsync/data


#Install Bitorrent Sync
ADD http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable /usr/bin/btsync.tar.gz
RUN cd /usr/bin && tar -xzvf btsync.tar.gz && rm btsync.tar.gz

#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh
ADD ./template/btsync.tmpl /srv/btsync/config/btsync.tmpl

VOLUME [ "/srv/btsync/config", "/srv/btsync/data"]

# Web GUI
EXPOSE 8081
# Listening port
EXPOSE 55555

CMD ["/srv/start.sh"]