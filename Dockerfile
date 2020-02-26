FROM    alpine:3.10
LABEL   maintainer="QED"

ARG     BUILD_DATE
ARG     VCS_REF
ARG     BUILD_VERSION

## s6 overlay
ARG     S6_OVERLAY_VERSION="v1.22.1.0"
ARG     S6_OVERLAY_ARCH="amd64"

ENV     \
        TZ="UTC"

LABEL   org.label-schema.schema-version="1.0" \
        org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="docker-base-alpine" \
        org.label-schema.description="Custom Alpine Linux base image" \
        org.label-schema.url="https://github.com/qedadmin/docker-base-alpine" \
        org.label-schema.vcs-url="https://github.com/qedadmin/docker-base-alpine.git" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vendor="qedadmin" \
        org.label-schema.version=$BUILD_VERSION

## Install packages
RUN     \
        echo "**** Install packages ****" && \
        apk add --no-cache bash curl openssl tzdata

## root filesystem
COPY    root /

## s6 overlay
ADD     https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-${S6_OVERLAY_ARCH}.tar.gz /tmp/s6-overlay.tar.gz
RUN     \
        echo "**** Install s6 overlay ****" && \
        tar xvfz /tmp/s6-overlay.tar.gz -C / && \
        rm /tmp/s6-overlay.tar.gz

RUN     echo "**** Done ****"

## init
ENTRYPOINT [ "/init" ]
