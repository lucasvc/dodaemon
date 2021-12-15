# Docker Daemon for Windows

This is a simple way of having an _only_ Docker Daemon executing on a Windows.

It is bases it use in,

* Windows Subsystem for Linux (aka WSL) in its 2 version.
* [`wsldl`](https://github.com/yuk7/wsldl/) tool by [yuk7](https://github.com/yuk7), which allows to have multiple distributions as _folders_.
* A minimal Linux distro, in a first version [Alpine](https://alpinelinux.org/).

and nothing more :)
No Docker Desktop or anything more.

## Requirements

* Windows 10 2004 and higher (Build 19041 and higher).
* WSL version 2 is enabled.

## Install

```
make.bat install
```
will create the `dodaemon` WSL version 2 distribution in the local folder.

## Usage

Once installed,

```
ddd.bat
```

It will run in the same command line window showing the daemon logs.

## Released

You can also donwload the already built package from the Releases with the Alpine version indicated.
