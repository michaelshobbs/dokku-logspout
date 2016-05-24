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
cd /var/lib/dokku/plugins (or /var/lib/dokku/plugins/ava)
git clone https://github.com/michaelshobbs/dokku-logspout.git dokku-logspout
dokku plugins-install
```
```
# dokku 0.4.x
dokku plugin:install https://github.com/michaelshobbs/dokku-logspout.git
```

### Customization

Configuration settings are stored in `/home/dokku/.logspout/OPTS`. If you would like
to use a specific version of the logspout container, you can edit `OPTS` and modify
the `DOKKU_LOGSPOUT_IMAGE_VERSION` to point to a specific image version.

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
