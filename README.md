# argonath-kenny-loggins
## A Kong plugin to handle Cloud Elements audit logging
[![version](http://img.shields.io/badge/version-v0.0.1-blue.svg)](#)
[![versioning](http://img.shields.io/badge/versioning-semver-blue.svg)](http://semver.org/)
[![branching](http://img.shields.io/badge/branching-github%20flow-blue.svg)](https://guides.github.com/introduction/flow/)


## Overview
Kenny Loggins is a fork of Kong's v0.10.3 [syslog](https://getkong.org/plugins/syslog/) plugin

![Kenny Loggins](https://upload.wikimedia.org/wikipedia/en/0/07/%22This_Is_It%22_by_Kenny_Loggins.jpg)


## Installation

Install the module one of the two following ways and then update the `custom_plugins` setting
within `kong.conf` or export the `KONG_CUSTOM_PLUGINS` environment variable. Finally, restart Kong.

### Via `luarocks`:

```bash
$ luarocks make kong-plugin-argonath-kenny-loggins-0.0.1-1.rockspec
```

### Via `npm`:

```bash
$ npm install @cloudelements/argonath-kenny-loggins
```

## Uninstall

### Via `luarocks`

```bash
$ luarocks remove argonath-kenny-loggins
```

## Development and Testing

You can develop and test this and other Kong plugins via Mashape's [kong-vagrant](https://github.com/Mashape/kong-vagrant).

```bash
# locally:
$ cd ~/workspace/kong-vagrant
# deploy Kong development environment and mount local plugin path to Kong development box at /plugin
$ KONG_PLUGIN_PATH=../argonath-kenny-loggins vagrant up
# SSH to Kong development box
$ vagrant ssh
```

```bash
# on Kong development box:
# install plugin
$ cd /plugin
$ make
# install Kong
$ cd /kong
$ make dev
# run tests
$ KONG_CUSTOM_PLUGINS=argonath-kenny-loggins bin/busted -v /plugin/test
```