# Docker Daemon for Windows

This is a simple way of having an _only_ Docker Daemon executing on a Windows.

It is bases it use in,

* [Windows Subsystem for Linux](https://learn.microsoft.com/en-gb/windows/wsl/about#what-is-wsl-2) (aka WSL) in its version 2.
* [`wsldl`](https://github.com/yuk7/wsldl/) tool by [yuk7](https://github.com/yuk7), which allows to have multiple Linux distributions organized as _folders_.
* A minimal Linux root filesystem (aka `rootfs`), currently an [Alpine](https://alpinelinux.org/) using the "Minimal root filesystem" package.

and nothing more :)
No Docker Desktop, nor full virtual machine.

## Requirements

* Windows 10 2004 and higher (Build 19041 and higher).
* WSL version 2 is enabled.

## Create

```
.\make.ps1
```
// TODO replace with a `-Create` flag

### Options

| Option | Description | Mandatory |
| ------ | ----------- | --------- |
|`Destination` | Can be used to select installation folder | No |

## Export

// TODO create `make.ps1 -Export`
// until that...
One of the most fancy things of WSL is its portability: a "packaged" can be used into different computers without issues. To export a current installed one,

```
.\dodaemon.exe backup --vhdx && Rename-Item backup.ext4.vhdx install.ext4.vhdx
```

Packaging files:
- `install.ext4.vhdx`
- `dodaemon.exe`
- `ddd.bat`

are enough to be used on other computer.

## Usage

Once installed execute the file,

```
ddd.bat
```

and a Docker Daemon will run in the same command line window showing the daemon logs. You can connect to it using the environment variable

```
DOCKER_HOST=tcp://localhost:2375
```

Or opening a new `dodaemon.exe` command line it will be also accessible through the socket.

## Released

You can also donwload the already built package from the Releases with the Alpine version indicated and follow the [Usage](#usage) section.
