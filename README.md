Logspout plugin for Dokku
=========================

Project: https://github.com/dokku/dokku & https://github.com/gliderlabs/logspout

Requirements
------------
* Dokku version `0.3.10` or higher

Installation
-----------
```
# dokku 0.3.x
$ cd /var/lib/dokku/plugins (or /var/lib/dokku/plugins/ava)
$ git clone https://github.com/michaelshobbs/dokku-logspout.git dokku-logspout
dokku plugins-install
```
```
# dokku 0.4.x
$ dokku plugin:install https://github.com/michaelshobbs/dokku-logspout.git
```

### Customization
Pre install, you can set the `$DOKKU_LOGSPOUT_IMAGE_VERSION` environment variable to pull a specific
version of the `logspout` docker image.
```
$ DOKKU_LOGSPOUT_IMAGE_VERSION=v3.1 dokku plugin:install https://github.com/michaelshobbs/dokku-logspout.git
```
Post install, configuration settings are stored in `/home/dokku/.logspout/OPTS`. If you would like
to use a specific version of the logspout container, you can edit `OPTS` and modify
the `DOKKU_LOGSPOUT_IMAGE_VERSION` to point to a specific image version. Then you will need to
update and relaunch the logspout container.
```
$ docker ps
CONTAINER ID        IMAGE                      COMMAND                  CREATED              STATUS              PORTS                               NAMES
43f6cce913a6        gliderlabs/logspout:v3     "/bin/logspout syslog"   About a minute ago   Up About a minute   8000/tcp, 127.0.0.1:18000->80/tcp   logspout
$ vi /home/dokku/.logspout/OPTS
$ dokku logspout:update
43f6cce913a6ed54b60afbb56aa14d74e9b052d4bde816147dfd0a9adfa50935
v3.1: Pulling from gliderlabs/logspout

7aabe7f6bcce: Already exists
21cc8427d31e: Pull complete
b27c5e8c5f8e: Pull complete
Digest: sha256:028b5f6f49d87a10e0c03208156ffedcef6da2e7f59efa8886640ba15cbe0e69
Status: Downloaded newer image for gliderlabs/logspout:v3.1
$ docker ps
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS              PORTS                     NAMES
c7b1414cc465        gliderlabs/logspout:v3.1   "/bin/logspout syslog"   1 seconds ago       Up 1 seconds        127.0.0.1:18000->80/tcp   logspout
```

If you need to change the environment variables used by logspout, you can add these to the `/home/dokku/.logspout/ENV` file, for example:
```
SYSLOG_HOSTNAME=www.my-dokku-host.com
SYSLOG_TAG={{.Container.Config.Hostname}}
```
When changing the variable file, you have to restart the logspout container: `dokku logspout:stop && dokku logspout:start`

Commands
--------
```
$ dokku help
    logspout:destroy                                destroy logspout container
    logspout:info                                   show status of running container
    logspout:port <port>                            set local logspout port
    logspout:server <server-url>                    set remote syslog server
    logspout:start                                  start logspout container
    logspout:stop                                   stop logspout container
    logspout:stream                                 print log stream to stdout
    logspout:update                                 updates the logspout docker image
```

## Contributing

Feel free to fork and create a Pull Request. (Please add your name to AUTHORS)

## License

MIT
