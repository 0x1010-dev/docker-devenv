# docker-devenv

A Docker containing a full Ubuntu-based developer environment, running an SSH daemon by default for remote access.

- Persistent home directory at `/home-persistent` for bind mounting.
- Homebrew installed in `/home/linuxbrew` and accesible by all users for persistent package installation.
- Docker can be used from withing the environment.

## docker cli

```
docker run -d \
    --privileged \
    --name=devenv \
    --hostname=devenv `#optional` \
    -v /path/to/persistent/home:/persistent-home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --restart unless-stopped \
    x1010dev/devenv
```

