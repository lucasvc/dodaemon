@echo off
setlocal enableDelayedExpansion
set dodaemon=%~dp0\dodaemon.exe
%dodaemon% isregd || (
    echo "dodaemon" WSL distribution not installed
    @REM echo y | %dodaemon% >nul
    %dodaemon% install
    del /F %~dp0\install.ext4.vhdx
)
%dodaemon% run sh -c "socat TCP-LISTEN:2375,reuseaddr,fork UNIX-CLIENT:/var/run/docker.sock & dockerd"
