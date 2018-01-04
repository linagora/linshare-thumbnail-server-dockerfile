What is LinShare Thumbnail Server ?
===================================

This standalone server will generate some preview from an input file (png, pdf,
odt, ...)

How to use this image
=====================

Run
---

To start using this image with the defaults settings, you can run the following commands :

```console
$ docker run -d -p 8080:8080 -p 8081:8081 linagora/linshare-thumbnail-server
```

Build
-----

This repository is capable of building stable or snapshot release of upload proposition module.
You can set a custom version number on the command-line by using the --build-args switch.

CHANNEL argument can be set to `releases` or `snapshots`.
Stable `releases` channel is selected by default.


```console
$ docker build --build-arg VERSION=2.0.0 --build-arg CHANNEL=releases -t linshare-thumbnail-server .
$ docker build --build-arg VERSION=2.0.0-SNAPSHOT --build-arg CHANNEL=snapshots -t linshare-thumbnail-server .
```

Test
----

```console
curl -i 'http://localhost:8080/linthumbnail/?mimeType=image/png' -X POST \
    -H "Content-Type: multipart/form-data" \
    -F"file=@Tux-G2b.png" \
    --output /tmp/preview.multipart.binary
```
