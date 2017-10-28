#!/bin/bash
set -e

mkdir -p /SHARE/video_archive /opt/ivideon/videoserverd

[ ! -f /SHARE/config.xml ]                     && cp /DEFAULT/config.xml          /SHARE/config.xml
[ ! -f /opt/ivideon/videoserverd/config.xml  ] && ln -s /SHARE/config.xml         /opt/ivideon/videoserverd/config.xml

[ ! -f /SHARE/videoserverd.config ]                       && cp /DEFAULT/videoserverd.config /SHARE/videoserverd.config
[ ! -f /opt/ivideon/ivideon-server/videoserverd.config  ] && ln -s /SHARE/videoserverd.config   /opt/ivideon/ivideon-server/videoserverd.config

[ ! -f /SHARE/schedule.json ]                      && cp /DEFAULT/schedule.json       /SHARE/schedule.json
[ ! -f /opt/ivideon/ivideon-server/schedule.json ] && ln -s /SHARE/schedule.json         /opt/ivideon/ivideon-server/schedule.json

touch /SHARE/service.log
[ ! -f /opt/ivideon/ivideon-server/service.log ] && ln -s /SHARE/service.log         /opt/ivideon/ivideon-server/service.log

chown -R www-data:www-data /SHARE/*

/etc/init.d/videoserver start

tail -f /opt/ivideon/ivideon-server/service.log

