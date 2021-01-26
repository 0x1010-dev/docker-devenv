# docker-devenv

A Docker containing a full Ubuntu-based developer environment, running an SSH daemon by default for remote access.

- Homebrew installed in `/home/linuxbrew` for installing packages (apt installed packages will not persist). 
- Persistent storage at `/persistent` to preserve user data and homebrew packages across sessions.
- Docker can be used from withing the environment.

## docker cli

```
docker run -d \
    --privileged \
    --name=devenv \
    --hostname=devenv `#optional` \
    -v /path/to/persistent/storage:/persistent \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e SSHD_PORT=2222 \
    --restart unless-stopped \
    x1010dev/devenv
```

