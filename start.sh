#!/usr/bin/env bash
if [ ! -f /srv/btsync/config/btsync.conf ]; then
	#generate the config file for the first time using conf.d
	confd -onetime -backend rancher -prefix /2015-07-25
	chown -R depot:depot /srv/btsync
fi

su -c "btsync --config /srv/btsync/config/btsync.conf --nodaemon" depot