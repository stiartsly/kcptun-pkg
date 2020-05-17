BUILD_DIR=$(PWD)/build
INT_DIR=${BUILD_DIR}/int
BIN_DIR=${INT_DIR}/kcptun/build
DIST_DIR=${BUILD_DIR}/dist

export GOPATH=${INT_DIR}/go

BUILD_DATE=`date +%Y%m%d`

all: mkpkg

mkpkg: server-amd64 client-amd64 server-arm7 client-arm7

server-amd64: ${INT_DIR}/kcptun
	mkdir -p $(DIST_DIR)/server-debian-amd64/usr/bin
	cp ${BIN_DIR}/server_linux_amd64 $(DIST_DIR)/server-debian-amd64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_amd64 $(DIST_DIR)/server-debian-amd64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/server-debian-amd64/etc/shadowtun
	cp config/ss-server.conf $(DIST_DIR)/server-debian-amd64/etc/shadowtun/ss.conf
	cp config/oc-server.conf $(DIST_DIR)/server-debian-amd64/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/server-debian-amd64/lib/systemd/system
	cp scripts/shadowtun-ss.service $(DIST_DIR)/server-debian-amd64/lib/systemd/system/shadowtun-ss.service
	cp scripts/shadowtun-oc.service $(DIST_DIR)/server-debian-amd64/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/server-debian-amd64/etc/init.d
	cp scripts/shadowtun-ss.sh $(DIST_DIR)/server-debian-amd64/etc/init.d/shadowtun-ss
	cp scripts/shadowtun-oc.sh $(DIST_DIR)/server-debian-amd64/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/server-debian-amd64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/server-debian-amd64/DEBIAN
	cp debian/* $(DIST_DIR)/server-debian-amd64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-amd64/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-amd64/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-amd64/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-amd64/lib/systemd/system/shadowtun-oc.service

	sed -i "s%build\-date%${BUILD_DATE}%" $(DIST_DIR)/server-debian-amd64/DEBIAN/control
	sed -i "s%target\-arch%amd64%" $(DIST_DIR)/server-debian-amd64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/server-debian-amd64 $(DIST_DIR)/shadowtun-server-amd64.deb

client-amd64: ${INT_DIR}/kcptun
	mkdir -p $(DIST_DIR)/client-debian-amd64/usr/bin
	cp ${BIN_DIR}/server_linux_amd64 $(DIST_DIR)/client-debian-amd64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_amd64 $(DIST_DIR)/client-debian-amd64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/client-debian-amd64/etc/shadowtun
	cp config/ss-client.conf $(DIST_DIR)/client-debian-amd64/etc/shadowtun/ss.conf
	cp config/oc-client.conf $(DIST_DIR)/client-debian-amd64/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/client-debian-amd64/lib/systemd/system
	cp scripts/shadowtun-ss.service $(DIST_DIR)/client-debian-amd64/lib/systemd/system/shadowtun-ss.service
	cp scripts/shadowtun-oc.service $(DIST_DIR)/client-debian-amd64/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/client-debian-amd64/etc/init.d
	cp scripts/shadowtun-ss.sh $(DIST_DIR)/client-debian-amd64/etc/init.d/shadowtun-ss
	cp scripts/shadowtun-oc.sh $(DIST_DIR)/client-debian-amd64/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/client-debian-amd64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/client-debian-amd64/DEBIAN
	cp debian/* $(DIST_DIR)/client-debian-amd64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-amd64/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-amd64/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-amd64/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-amd64/lib/systemd/system/shadowtun-oc.service

	sed -i "s%build\-date%${BUILD_DATE}%" $(DIST_DIR)/client-debian-amd64/DEBIAN/control
	sed -i "s%target\-arch%amd64%" $(DIST_DIR)/client-debian-amd64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/client-debian-amd64 $(DIST_DIR)/shadowtun-client-amd64.deb

server-arm7: ${INT_DIR}/kcptun
	mkdir -p $(DIST_DIR)/server-debian-arm7/usr/bin
	cp ${BIN_DIR}/server_linux_arm7 $(DIST_DIR)/server-debian-arm7/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm7 $(DIST_DIR)/server-debian-arm7/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/server-debian-arm7/etc/shadowtun
	cp config/ss-server.conf $(DIST_DIR)/server-debian-arm7/etc/shadowtun/ss.conf
	cp config/oc-server.conf $(DIST_DIR)/server-debian-arm7/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/server-debian-arm7/lib/systemd/system
	cp scripts/shadowtun-ss.service $(DIST_DIR)/server-debian-arm7/lib/systemd/system/shadowtun-ss.service
	cp scripts/shadowtun-oc.service $(DIST_DIR)/server-debian-arm7/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/server-debian-arm7/etc/init.d
	cp scripts/shadowtun-ss.sh $(DIST_DIR)/server-debian-arm7/etc/init.d/shadowtun-ss
	cp scripts/shadowtun-oc.sh $(DIST_DIR)/server-debian-arm7/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/server-debian-arm7/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/server-debian-arm7/DEBIAN
	cp debian/* $(DIST_DIR)/server-debian-arm7/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-arm7/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-arm7/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-arm7/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/server-debian-arm7/lib/systemd/system/shadowtun-oc.service

	sed -i "s%build\-date%${BUILD_DATE}%" $(DIST_DIR)/server-debian-arm7/DEBIAN/control
	sed -i "s%target\-arch%armhf%" $(DIST_DIR)/server-debian-arm7/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/server-debian-arm7 $(DIST_DIR)/shadowtun-server-arm7.deb

client-arm7: ${INT_DIR}/kcptun
	mkdir -p $(DIST_DIR)/client-debian-arm7/usr/bin
	cp ${BIN_DIR}/server_linux_arm7 $(DIST_DIR)/client-debian-arm7/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm7 $(DIST_DIR)/client-debian-arm7/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/client-debian-arm7/etc/shadowtun
	cp config/ss-client.conf $(DIST_DIR)/client-debian-arm7/etc/shadowtun/ss.conf
	cp config/oc-client.conf $(DIST_DIR)/client-debian-arm7/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/client-debian-arm7/lib/systemd/system
	cp scripts/shadowtun-ss.service $(DIST_DIR)/client-debian-arm7/lib/systemd/system/shadowtun-ss.service
	cp scripts/shadowtun-oc.service $(DIST_DIR)/client-debian-arm7/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/client-debian-arm7/etc/init.d
	cp scripts/shadowtun-ss.sh $(DIST_DIR)/client-debian-arm7/etc/init.d/shadowtun-ss
	cp scripts/shadowtun-oc.sh $(DIST_DIR)/client-debian-arm7/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/client-debian-arm7/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/client-debian-arm7/DEBIAN
	cp debian/* $(DIST_DIR)/client-debian-arm7/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-arm7/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-arm7/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-arm7/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/client-debian-arm7/lib/systemd/system/shadowtun-oc.service

	sed -i "s%build\-date%${BUILD_DATE}%" $(DIST_DIR)/client-debian-arm7/DEBIAN/control
	sed -i "s%target\-arch%armhf%" $(DIST_DIR)/client-debian-arm7/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/client-debian-arm7 $(DIST_DIR)/shadowtun-client-arm7.deb

${INT_DIR}/kcptun: ${INT_DIR}/kcptun-src
	cd ${INT_DIR}/kcptun && ./build-release.sh
	touch ${INT_DIR}/kcptun

${INT_DIR}/kcptun-src:
	mkdir -p ${INT_DIR}
	mkdir -p ${GOPATH}
	cd ${INT_DIR} && git clone --branch v20200409 https://github.com/xtaci/kcptun.git
	rm -rf ${INT_DIT}/kcptun/build/*
	touch ${INT_DIR}/kcptun-src
