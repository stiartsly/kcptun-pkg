BUILD_DIR=$(PWD)/build
INT_DIR=${BUILD_DIR}/int
BIN_DIR=${INT_DIR}/kcptun/build
DIST_DIR=${BUILD_DIR}/dist

export GOPATH=${INT_DIR}/go

VERSION=v20210922

all: mkpkg

mkpkg: vpn std

vpn: vpn-server-amd64 vpn-client-amd64 vpn-server-arm64 vpn-client-arm64 vpn-server-arm7 vpn-client-arm7

std: std-server-amd64 std-client-amd64 std-server-arm64 std-client-arm64 std-server-arm7 std-client-arm7

vpn-server-amd64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/vpn-server-debian-amd64/usr/bin
	cp ${BIN_DIR}/server_linux_amd64 $(DIST_DIR)/vpn-server-debian-amd64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_amd64 $(DIST_DIR)/vpn-server-debian-amd64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/vpn-server-debian-amd64/etc/shadowtun
	cp vpn/config/ss-server.conf $(DIST_DIR)/vpn-server-debian-amd64/etc/shadowtun/ss.conf
	cp vpn/config/oc-server.conf $(DIST_DIR)/vpn-server-debian-amd64/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/vpn-server-debian-amd64/lib/systemd/system
	cp vpn/scripts/shadowtun-ss.service $(DIST_DIR)/vpn-server-debian-amd64/lib/systemd/system/shadowtun-ss.service
	cp vpn/scripts/shadowtun-oc.service $(DIST_DIR)/vpn-server-debian-amd64/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/vpn-server-debian-amd64/etc/init.d
	cp vpn/scripts/shadowtun-ss.sh $(DIST_DIR)/vpn-server-debian-amd64/etc/init.d/shadowtun-ss
	cp vpn/scripts/shadowtun-oc.sh $(DIST_DIR)/vpn-server-debian-amd64/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/vpn-server-debian-amd64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/vpn-server-debian-amd64/DEBIAN
	cp vpn/debian/* $(DIST_DIR)/vpn-server-debian-amd64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-amd64/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-amd64/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-amd64/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-amd64/lib/systemd/system/shadowtun-oc.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/vpn-server-debian-amd64/DEBIAN/control
	sed -i "s%target\-arch%amd64%" $(DIST_DIR)/vpn-server-debian-amd64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/vpn-server-debian-amd64 $(DIST_DIR)/vpn-shadowtun-server-amd64.deb

vpn-client-amd64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/vpn-client-debian-amd64/usr/bin
	cp ${BIN_DIR}/server_linux_amd64 $(DIST_DIR)/vpn-client-debian-amd64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_amd64 $(DIST_DIR)/vpn-client-debian-amd64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/vpn-client-debian-amd64/etc/shadowtun
	cp vpn/config/ss-client.conf $(DIST_DIR)/vpn-client-debian-amd64/etc/shadowtun/ss.conf
	cp vpn/config/oc-client.conf $(DIST_DIR)/vpn-client-debian-amd64/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/vpn-client-debian-amd64/lib/systemd/system
	cp vpn/scripts/shadowtun-ss.service $(DIST_DIR)/vpn-client-debian-amd64/lib/systemd/system/shadowtun-ss.service
	cp vpn/scripts/shadowtun-oc.service $(DIST_DIR)/vpn-client-debian-amd64/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/vpn-client-debian-amd64/etc/init.d
	cp vpn/scripts/shadowtun-ss.sh $(DIST_DIR)/vpn-client-debian-amd64/etc/init.d/shadowtun-ss
	cp vpn/scripts/shadowtun-oc.sh $(DIST_DIR)/vpn-client-debian-amd64/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/vpn-client-debian-amd64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/vpn-client-debian-amd64/DEBIAN
	cp vpn/debian/* $(DIST_DIR)/vpn-client-debian-amd64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-amd64/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-amd64/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-amd64/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-amd64/lib/systemd/system/shadowtun-oc.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/vpn-client-debian-amd64/DEBIAN/control
	sed -i "s%target\-arch%amd64%" $(DIST_DIR)/vpn-client-debian-amd64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/vpn-client-debian-amd64 $(DIST_DIR)/vpn-shadowtun-client-amd64.deb

vpn-server-arm7: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm7/usr/bin
	cp ${BIN_DIR}/server_linux_arm7 $(DIST_DIR)/vpn-server-debian-arm7/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm7 $(DIST_DIR)/vpn-server-debian-arm7/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm7/etc/shadowtun
	cp vpn/config/ss-server.conf $(DIST_DIR)/vpn-server-debian-arm7/etc/shadowtun/ss.conf
	cp vpn/config/oc-server.conf $(DIST_DIR)/vpn-server-debian-arm7/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm7/lib/systemd/system
	cp vpn/scripts/shadowtun-ss.service $(DIST_DIR)/vpn-server-debian-arm7/lib/systemd/system/shadowtun-ss.service
	cp vpn/scripts/shadowtun-oc.service $(DIST_DIR)/vpn-server-debian-arm7/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm7/etc/init.d
	cp vpn/scripts/shadowtun-ss.sh $(DIST_DIR)/vpn-server-debian-arm7/etc/init.d/shadowtun-ss
	cp vpn/scripts/shadowtun-oc.sh $(DIST_DIR)/vpn-server-debian-arm7/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm7/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm7/DEBIAN
	cp vpn/debian/* $(DIST_DIR)/vpn-server-debian-arm7/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm7/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm7/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm7/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm7/lib/systemd/system/shadowtun-oc.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/vpn-server-debian-arm7/DEBIAN/control
	sed -i "s%target\-arch%armhf%" $(DIST_DIR)/vpn-server-debian-arm7/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/vpn-server-debian-arm7 $(DIST_DIR)/vpn-shadowtun-server-arm7.deb

vpn-client-arm7: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm7/usr/bin
	cp ${BIN_DIR}/server_linux_arm7 $(DIST_DIR)/vpn-client-debian-arm7/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm7 $(DIST_DIR)/vpn-client-debian-arm7/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm7/etc/shadowtun
	cp vpn/config/ss-client.conf $(DIST_DIR)/vpn-client-debian-arm7/etc/shadowtun/ss.conf
	cp vpn/config/oc-client.conf $(DIST_DIR)/vpn-client-debian-arm7/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm7/lib/systemd/system
	cp vpn/scripts/shadowtun-ss.service $(DIST_DIR)/vpn-client-debian-arm7/lib/systemd/system/shadowtun-ss.service
	cp vpn/scripts/shadowtun-oc.service $(DIST_DIR)/vpn-client-debian-arm7/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm7/etc/init.d
	cp vpn/scripts/shadowtun-ss.sh $(DIST_DIR)/vpn-client-debian-arm7/etc/init.d/shadowtun-ss
	cp vpn/scripts/shadowtun-oc.sh $(DIST_DIR)/vpn-client-debian-arm7/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm7/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm7/DEBIAN
	cp vpn/debian/* $(DIST_DIR)/vpn-client-debian-arm7/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm7/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm7/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm7/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm7/lib/systemd/system/shadowtun-oc.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/vpn-client-debian-arm7/DEBIAN/control
	sed -i "s%target\-arch%armhf%" $(DIST_DIR)/vpn-client-debian-arm7/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/vpn-client-debian-arm7 $(DIST_DIR)/vpn-shadowtun-client-arm7.deb

vpn-server-arm64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm64/usr/bin
	cp ${BIN_DIR}/server_linux_arm64 $(DIST_DIR)/vpn-server-debian-arm64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm64 $(DIST_DIR)/vpn-server-debian-arm64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm64/etc/shadowtun
	cp vpn/config/ss-server.conf $(DIST_DIR)/vpn-server-debian-arm64/etc/shadowtun/ss.conf
	cp vpn/config/oc-server.conf $(DIST_DIR)/vpn-server-debian-arm64/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm64/lib/systemd/system
	cp vpn/scripts/shadowtun-ss.service $(DIST_DIR)/vpn-server-debian-arm64/lib/systemd/system/shadowtun-ss.service
	cp vpn/scripts/shadowtun-oc.service $(DIST_DIR)/vpn-server-debian-arm64/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm64/etc/init.d
	cp vpn/scripts/shadowtun-ss.sh $(DIST_DIR)/vpn-server-debian-arm64/etc/init.d/shadowtun-ss
	cp vpn/scripts/shadowtun-oc.sh $(DIST_DIR)/vpn-server-debian-arm64/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/vpn-server-debian-arm64/DEBIAN
	cp vpn/debian/* $(DIST_DIR)/vpn-server-debian-arm64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm64/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm64/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm64/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/vpn-server-debian-arm64/lib/systemd/system/shadowtun-oc.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/vpn-server-debian-arm64/DEBIAN/control
	sed -i "s%target\-arch%arm64%" $(DIST_DIR)/vpn-server-debian-arm64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/vpn-server-debian-arm64 $(DIST_DIR)/vpn-shadowtun-server-arm64.deb

vpn-client-arm64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm64/usr/bin
	cp ${BIN_DIR}/server_linux_arm64 $(DIST_DIR)/vpn-client-debian-arm64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm64 $(DIST_DIR)/vpn-client-debian-arm64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm64/etc/shadowtun
	cp vpn/config/ss-client.conf $(DIST_DIR)/vpn-client-debian-arm64/etc/shadowtun/ss.conf
	cp vpn/config/oc-client.conf $(DIST_DIR)/vpn-client-debian-arm64/etc/shadowtun/oc.conf
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm64/lib/systemd/system
	cp vpn/scripts/shadowtun-ss.service $(DIST_DIR)/vpn-client-debian-arm64/lib/systemd/system/shadowtun-ss.service
	cp vpn/scripts/shadowtun-oc.service $(DIST_DIR)/vpn-client-debian-arm64/lib/systemd/system/shadowtun-oc.service
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm64/etc/init.d
	cp vpn/scripts/shadowtun-ss.sh $(DIST_DIR)/vpn-client-debian-arm64/etc/init.d/shadowtun-ss
	cp vpn/scripts/shadowtun-oc.sh $(DIST_DIR)/vpn-client-debian-arm64/etc/init.d/shadowtun-oc
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/vpn-client-debian-arm64/DEBIAN
	cp vpn/debian/* $(DIST_DIR)/vpn-client-debian-arm64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm64/etc/init.d/shadowtun-ss
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm64/etc/init.d/shadowtun-oc
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm64/lib/systemd/system/shadowtun-ss.service
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/vpn-client-debian-arm64/lib/systemd/system/shadowtun-oc.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/vpn-client-debian-arm64/DEBIAN/control
	sed -i "s%target\-arch%arm64%" $(DIST_DIR)/vpn-client-debian-arm64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/vpn-client-debian-arm64 $(DIST_DIR)/vpn-shadowtun-client-arm64.deb

std-server-amd64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/std-server-debian-amd64/usr/bin
	cp ${BIN_DIR}/server_linux_amd64 $(DIST_DIR)/std-server-debian-amd64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_amd64 $(DIST_DIR)/std-server-debian-amd64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/std-server-debian-amd64/etc/shadowtun
	cp std/config/server.conf $(DIST_DIR)/std-server-debian-amd64/etc/shadowtun/default.conf
	mkdir -p $(DIST_DIR)/std-server-debian-amd64/lib/systemd/system
	cp std/scripts/shadowtun.service $(DIST_DIR)/std-server-debian-amd64/lib/systemd/system/shadowtun.service
	mkdir -p $(DIST_DIR)/std-server-debian-amd64/etc/init.d
	cp std/scripts/shadowtun.sh $(DIST_DIR)/std-server-debian-amd64/etc/init.d/shadowtun
	mkdir -p $(DIST_DIR)/std-server-debian-amd64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/std-server-debian-amd64/DEBIAN
	cp std/debian/* $(DIST_DIR)/std-server-debian-amd64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/std-server-debian-amd64/etc/init.d/shadowtun
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/std-server-debian-amd64/lib/systemd/system/shadowtun.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/std-server-debian-amd64/DEBIAN/control
	sed -i "s%target\-arch%amd64%" $(DIST_DIR)/std-server-debian-amd64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/std-server-debian-amd64 $(DIST_DIR)/std-shadowtun-server-amd64.deb

std-client-amd64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/std-client-debian-amd64/usr/bin
	cp ${BIN_DIR}/server_linux_amd64 $(DIST_DIR)/std-client-debian-amd64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_amd64 $(DIST_DIR)/std-client-debian-amd64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/std-client-debian-amd64/etc/shadowtun
	cp std/config/client.conf $(DIST_DIR)/std-client-debian-amd64/etc/shadowtun/default.conf
	mkdir -p $(DIST_DIR)/std-client-debian-amd64/lib/systemd/system
	cp std/scripts/shadowtun.service $(DIST_DIR)/std-client-debian-amd64/lib/systemd/system/shadowtun.service
	mkdir -p $(DIST_DIR)/std-client-debian-amd64/etc/init.d
	cp std/scripts/shadowtun.sh $(DIST_DIR)/std-client-debian-amd64/etc/init.d/shadowtun
	mkdir -p $(DIST_DIR)/std-client-debian-amd64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/std-client-debian-amd64/DEBIAN
	cp std/debian/* $(DIST_DIR)/std-client-debian-amd64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/std-client-debian-amd64/etc/init.d/shadowtun
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/std-client-debian-amd64/lib/systemd/system/shadowtun.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/std-client-debian-amd64/DEBIAN/control
	sed -i "s%target\-arch%amd64%" $(DIST_DIR)/std-client-debian-amd64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/std-client-debian-amd64 $(DIST_DIR)/std-shadowtun-client-amd64.deb

std-server-arm7: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/std-server-debian-arm7/usr/bin
	cp ${BIN_DIR}/server_linux_arm7 $(DIST_DIR)/std-server-debian-arm7/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm7 $(DIST_DIR)/std-server-debian-arm7/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/std-server-debian-arm7/etc/shadowtun
	cp std/config/server.conf $(DIST_DIR)/std-server-debian-arm7/etc/shadowtun/default.conf
	mkdir -p $(DIST_DIR)/std-server-debian-arm7/lib/systemd/system
	cp std/scripts/shadowtun.service $(DIST_DIR)/std-server-debian-arm7/lib/systemd/system/shadowtun.service
	mkdir -p $(DIST_DIR)/std-server-debian-arm7/etc/init.d
	cp std/scripts/shadowtun.sh $(DIST_DIR)/std-server-debian-arm7/etc/init.d/shadowtun
	mkdir -p $(DIST_DIR)/std-server-debian-arm7/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/std-server-debian-arm7/DEBIAN
	cp std/debian/* $(DIST_DIR)/std-server-debian-arm7/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/std-server-debian-arm7/etc/init.d/shadowtun
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/std-server-debian-arm7/lib/systemd/system/shadowtun.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/std-server-debian-arm7/DEBIAN/control
	sed -i "s%target\-arch%armhf%" $(DIST_DIR)/std-server-debian-arm7/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/std-server-debian-arm7 $(DIST_DIR)/std-shadowtun-server-arm7.deb

std-client-arm7: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/std-client-debian-arm7/usr/bin
	cp ${BIN_DIR}/server_linux_arm7 $(DIST_DIR)/std-client-debian-arm7/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm7 $(DIST_DIR)/std-client-debian-arm7/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/std-client-debian-arm7/etc/shadowtun
	cp std/config/client.conf $(DIST_DIR)/std-client-debian-arm7/etc/shadowtun/default.conf
	mkdir -p $(DIST_DIR)/std-client-debian-arm7/lib/systemd/system
	cp std/scripts/shadowtun.service $(DIST_DIR)/std-client-debian-arm7/lib/systemd/system/shadowtun.service
	mkdir -p $(DIST_DIR)/std-client-debian-arm7/etc/init.d
	cp std/scripts/shadowtun.sh $(DIST_DIR)/std-client-debian-arm7/etc/init.d/shadowtun
	mkdir -p $(DIST_DIR)/std-client-debian-arm7/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/std-client-debian-arm7/DEBIAN
	cp std/debian/* $(DIST_DIR)/std-client-debian-arm7/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/std-client-debian-arm7/etc/init.d/shadowtun
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/std-client-debian-arm7/lib/systemd/system/shadowtun.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/std-client-debian-arm7/DEBIAN/control
	sed -i "s%target\-arch%armhf%" $(DIST_DIR)/std-client-debian-arm7/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/std-client-debian-arm7 $(DIST_DIR)/std-shadowtun-client-arm7.deb

std-server-arm64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/std-server-debian-arm64/usr/bin
	cp ${BIN_DIR}/server_linux_arm64 $(DIST_DIR)/std-server-debian-arm64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm64 $(DIST_DIR)/std-server-debian-arm64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/std-server-debian-arm64/etc/shadowtun
	cp std/config/server.conf $(DIST_DIR)/std-server-debian-arm64/etc/shadowtun/default.conf
	mkdir -p $(DIST_DIR)/std-server-debian-arm64/lib/systemd/system
	cp std/scripts/shadowtun.service $(DIST_DIR)/std-server-debian-arm64/lib/systemd/system/shadowtun.service
	mkdir -p $(DIST_DIR)/std-server-debian-arm64/etc/init.d
	cp std/scripts/shadowtun.sh $(DIST_DIR)/std-server-debian-arm64/etc/init.d/shadowtun
	mkdir -p $(DIST_DIR)/std-server-debian-arm64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/std-server-debian-arm64/DEBIAN
	cp std/debian/* $(DIST_DIR)/std-server-debian-arm64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/std-server-debian-arm64/etc/init.d/shadowtun
	sed -i "s%shadowtun\-prog%shadowtun\-server%" $(DIST_DIR)/std-server-debian-arm64/lib/systemd/system/shadowtun.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/std-server-debian-arm64/DEBIAN/control
	sed -i "s%target\-arch%arm64%" $(DIST_DIR)/std-server-debian-arm64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/std-server-debian-arm64 $(DIST_DIR)/std-shadowtun-server-arm64.deb

std-client-arm64: ${INT_DIR}/kcptun-bin
	mkdir -p $(DIST_DIR)/std-client-debian-arm64/usr/bin
	cp ${BIN_DIR}/server_linux_arm64 $(DIST_DIR)/std-client-debian-arm64/usr/bin/shadowtun-server
	cp ${BIN_DIR}/client_linux_arm64 $(DIST_DIR)/std-client-debian-arm64/usr/bin/shadowtun-client
	mkdir -p $(DIST_DIR)/std-client-debian-arm64/etc/shadowtun
	cp std/config/client.conf $(DIST_DIR)/std-client-debian-arm64/etc/shadowtun/default.conf
	mkdir -p $(DIST_DIR)/std-client-debian-arm64/lib/systemd/system
	cp std/scripts/shadowtun.service $(DIST_DIR)/std-client-debian-arm64/lib/systemd/system/shadowtun.service
	mkdir -p $(DIST_DIR)/std-client-debian-arm64/etc/init.d
	cp std/scripts/shadowtun.sh $(DIST_DIR)/std-client-debian-arm64/etc/init.d/shadowtun
	mkdir -p $(DIST_DIR)/std-client-debian-arm64/var/lib/shadowtun
	mkdir -p $(DIST_DIR)/std-client-debian-arm64/DEBIAN
	cp std/debian/* $(DIST_DIR)/std-client-debian-arm64/DEBIAN

	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/std-client-debian-arm64/etc/init.d/shadowtun
	sed -i "s%shadowtun\-prog%shadowtun\-client%" $(DIST_DIR)/std-client-debian-arm64/lib/systemd/system/shadowtun.service

	sed -i "s%version\-string%${VERSION}%" $(DIST_DIR)/std-client-debian-arm64/DEBIAN/control
	sed -i "s%target\-arch%arm64%" $(DIST_DIR)/std-client-debian-arm64/DEBIAN/control

	fakeroot dpkg-deb --build $(DIST_DIR)/std-client-debian-arm64 $(DIST_DIR)/std-shadowtun-client-arm64.deb

${INT_DIR}/kcptun-bin: ${INT_DIR}/kcptun-src
	cd ${INT_DIR}/kcptun && ./build-release.sh
	touch ${INT_DIR}/kcptun-bin

${INT_DIR}/kcptun-src:
	mkdir -p ${INT_DIR}
	mkdir -p ${GOPATH}
	cd ${INT_DIR} && git clone --branch ${VERSION} https://github.com/xtaci/kcptun.git
	sed -i "s%^VERSION=.*%VERSION=${VERSION}%" $(INT_DIR)/kcptun/build-release.sh
	rm -rf ${INT_DIT}/kcptun/build/*
	touch ${INT_DIR}/kcptun-src
