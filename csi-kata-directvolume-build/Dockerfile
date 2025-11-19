FROM alpine:3.22 AS builder

RUN apk add --no-cache go~=1.24 git make
RUN git clone https://github.com/kata-containers/kata-containers -b 3.23.0 --depth 1
RUN cd kata-containers/src/tools/csi-kata-directvolume && make

FROM alpine:3.19

LABEL description="Kata DirectVolume Driver"

RUN apk add --no-cache util-linux=2.39.3-r0 coreutils=9.4-r2 e2fsprogs=1.47.0-r5 xfsprogs=6.5.0-r0 xfsprogs-extra=6.5.0-r0 btrfs-progs=6.6.2-r0 \
    && apk update \
    && apk upgrade
COPY --from=builder kata-containers/src/tools/csi-kata-directvolume/bin/directvolplugin /kata-directvol-plugin
ENTRYPOINT ["/kata-directvol-plugin"]
