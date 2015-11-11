#!/usr/bin/env bash
if [ ! -f /srv/btsync/config/btsync.conf ]; then
	#generate the config file for the first time
	cheetah fill --oext conf --env /srv/btsync/config/btsync
fi

btsync \
	--config /srv/btsync/config/btsync.conf \
	--nodaemon