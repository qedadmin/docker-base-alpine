Custom base image built with Alpine Linux 3.10 and [S6 overlay](https://github.com/just-containers/s6-overlay).

## Usage

To get started.

### docker

```
docker create \
  --name=alpine3 \
  --net=bridge \
  -e TZ=UTC \
  --restart unless-stopped \
  qedadmin/base-alpine
```

## Parameters


| Parameter | Function |
| :---- | --- |
| `-e TZ=UTC` | Specify a timezone |
