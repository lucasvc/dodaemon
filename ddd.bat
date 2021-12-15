@echo off
setlocal enableDelayedExpansion
set dodaemon=%~dp0\dodaemon.exe
%dodaemon% isregd || (
    echo "dodaemon" WSL distribution not installed, trying to install with the provided `ext4.vhdx` file
    echo y | %dodaemon% >nul
)
%dodaemon% run sh -c "socat TCP-LISTEN:2375,reuseaddr,fork UNIX-CLIENT:/var/run/docker.sock & dockerd"
