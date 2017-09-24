# THIS IS A MULTI STAGE DOCKER FILE
FROM alpine:latest as build

ARG VERSION=1.12.0

# RUN set -x shell command is used to log the execution process of the RUN command. Helps to troubleshoot
# apk is the Alpine's package manager tool.
RUN apk add --no-cache --virtual .build-deps  \
        build-base                            \
        gnupg                                 \
        pcre-dev                              \
        wget                                  \
        zlib-dev                           

# Retrieve, verify and unpack Nginx source    \
RUN set -x && \
    mkdir -p tmp && cd tmp        && \
    gpg --keyserver pgp.mit.edu --recv-keys \
        B0F4253373F8F6F510D42178520A9993A1C052F8  && \
    wget -q http://nginx.org/download/nginx-${VERSION}.tar.gz && \
    wget -q http://nginx.org/download/nginx-${VERSION}.tar.gz.asc && \
    gpg --verify nginx-${VERSION}.tar.gz.asc  && \
    tar -xf nginx-${VERSION}.tar.gz

WORKDIR /tmp/nginx-${VERSION}

# Build and install nginx               \
RUN ./configure            \
        --with-ld-opt="-static" \
        --with-http_sub_module  && \
    make install  && \
    strip /usr/local/nginx/sbin/nginx

# Symlink access and error logs to /dev/stdout and /dev/stderr , \
# in order to make use of docker's logging mechanism \
RUN ln -sf /dev/stdout /usr/local/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/nginx/logs/error.log


#SECOND STAGE OF THE DOCKER FILE WHICH INVOLVES SERVING
FROM scratch

COPY --from=build /etc/passwd /etc/group /etc/
COPY --from=build /usr/local/nginx /usr/local/nginx

# Change default stop signal from SIGTERM to SIGQUIT
STOPSIGNAL SIGQUIT

# Export port
EXPOSE 80

# Define entrypoint and default params
ENTRYPOINT [ "/usr/local/nginx/sbin/nginx" ]
CMD [ "-g", "daemon off;" ]