#!/usr/bin/env sh

#run the default config script
sh /srv/config.sh

# download the latest version of btsync
if [[ ! -d /srv/btsync/app/btsync ]]; then
	#curl -o /srv/btsync/app/btsync.tar.gz https://download-cdn.getsync.com/stable/linux-glibc-x64/BitTorrent-Sync_glibc23_x64.tar.gz
	curl -o /srv/btsync/app/btsync.tar.gz "https://download-cdn.getsync.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz"
	tar -xzvf /srv/btsync/app/btsync.tar.gz -C /srv/btsync/app
	rm -rf /srv/btsync/app/btsync.tar.gz
fi

# generate config file.
if [ ! -f /srv/btsync/config/btsync.conf ]; then
cat << EOF > "/srv/btsync/config/btsync.conf"
{
  "storage_path" : "/srv/btsync/data",
  "listening_port" : 55555,
  "use_upnp" : false,
  "webui" :
  {
    "listen" : "0.0.0.0:8888",
    "login" : "${DEPOT_USER:-admin}",
    "password" : "${DEPOT_PASSWORD:-password}",
    "directory_root": "/mnt/",
  	"directory_root_policy" : "belowroot"
  }
}
EOF
fi

#chown the btsync directory by the new user
chown mediadepot:mediadepot -R /srv/btsync

# run btsync
su -c "/srv/btsync/app/btsync --config /srv/btsync/config/btsync.conf --nodaemon" mediadepot
