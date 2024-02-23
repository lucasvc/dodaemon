param (
    [string]$AlpineMajor = "3", # TODO max
    [string]$AlpineMinor = "19", # TODO max
    [string]$AlpinePatch = "1", # TODO max
    [string]$Destination
)

If ( [string]::IsNullOrEmpty(${Destination}) ) {
    $Destination = "."
}
else {
    $Current = pwd
    cp ddd.bat ${Destination}
    cd ${Destination}
}

$AlpineRootfs = "alpine-minirootfs-${AlpineMajor}.${AlpineMinor}.${AlpinePatch}-x86_64.tar.gz"
Invoke-WebRequest -Uri https://dl-cdn.alpinelinux.org/alpine/v${AlpineMajor}.${AlpineMinor}/releases/x86_64/${AlpineRootfs} -OutFile .

wsl --import dodaemon ${Destination} ${AlpineRootfs}

Invoke-WebRequest -Uri https://github.com/yuk7/wsldl/releases/latest/download/wsldl.exe -OutFile dodaemon.exe

## DNS resolution connection issues
# https://gist.github.com/ThePlenkov/6ecf2a43e2b3898e8cd4986d277b5ecf
.\dodaemon.exe run ash -c "{ cat > /etc/wsl.conf <<-'EOF'
[network]
generateResolvConf=false
EOF
} && { cat > /usr/local/bin/local_resolv.sh <<-'EOF'
#!/bin/sh
sed -i '/nameserver/d' /etc/resolv.conf
/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command '(Get-DnsClientServerAddress -AddressFamily IPv4).ServerAddresses | ForEach-Object { `"nameserver \`$_`" }' | tr -d '\r'| tee -a /etc/resolv.conf > /dev/null
EOF
} && chmod +x /usr/local/bin/local_resolv.sh && local_resolv.sh"
##### `local_resolv.sh` should be executed on each startup
wsl --terminate dodaemon
##

.\dodaemon.exe run ash -c "apk add socat docker"
# somewhere read that with a `daemon.json` should not need the `socat`
# https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue
# chmod 666 /var/run/docker.sock

rm -Recurse -Force ${AlpineRootfs}

If (![string]::IsNullOrEmpty(${Current})) {
    cd ${Current}
}
