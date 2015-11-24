#!/usr/bin/env bash
if [ ! -f /srv/btsync/config/btsync.conf ]; then
	#generate the config file for the first time
	cheetah fill --oext conf --env /srv/btsync/config/btsync
	mv /srv/btsync/tmpl/btsync.conf /srv/btsync/config/btsync.conf
	chown -R depot:depot /srv/btsync
fi

su -c "btsync --config /srv/btsync/config/btsync.conf --nodaemon" depot