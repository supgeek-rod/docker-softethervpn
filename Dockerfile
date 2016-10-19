FROM benyoo/alpine:3.4.20160812
MAINTAINER from www.dwhd.org by lookback (mondeolove@gmail.com)

ARG VERSION=${VERSION:-v4.21-9613-beta}
ARG VERSION_DATE=${VERSION_DATE:-2016.04.24}

ENV LANG=en_US.UTF-8 \
	TEMP_DIR=/tmp/softethervpn \
	TERM=linux

RUN set -x && \
	apk --update --no-cache upgrade && \
	apk add --no-cache --virtual build_package tar gcc git curl expat libssh2 pcre libc-dev readline-dev zlib-dev openssl-dev ncurses-dev make && \
	apk add --no-cache --virtual run_package iptables iproute2 && \
	mkdir -p ${TEMP_DIR} && \
	DOWNLOAD="http://www.softether-download.com/files/softether" && \
	DOWNLOAD="${DOWNLOAD}/${VERSION}-${VERSION_DATE}-tree/Source_Code/softether-src-${VERSION}.tar.gz" && \
	curl -Lk "${DOWNLOAD}"| tar xz -C ${TEMP_DIR} --strip-components=1 && \
	cd ${TEMP_DIR} && \
	cp src/makefiles/linux_64bit.mak Makefile && \
	make && \
	make install && \
	cd .. && \
	apk del --build_package tar gcc git curl expat libssh2 pcre libc-dev readline-dev zlib-dev openssl-dev ncurses-dev make wget && \
	rm -rf /var/cache/apk/* ${TEMP_DIR}

COPY entrypoint.sh /
EXPOSE 1194/tcp 1194/udp 443/tcp 4500/udp 500/udp 5555/tcp 992/tcp

ENTRYPOINT ["/entrypoint.sh"]
