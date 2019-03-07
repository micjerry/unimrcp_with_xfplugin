#!/bin/bash

die() {
    echo $1
    exit 1
}

setup() {
    [ -f bootstrap ] || die "bootstrap not exist"
    [ -f configure ] || die "configure not exist"
    ./bootstrap
    ./configure
    make
    make install
}

ld_config() {
    echo "/usr/local/lib" > /etc/ld.so.conf.d/unimrcp.conf
    ldconfig
}

start_config() {
    [ -f /etc/systemd/system/unimrcp.service ] && rm /etc/systemd/system/unimrcp.service
    cp unimrcp.service /etc/systemd/system/
    systemctl enable unimrcp.service
}

setup
ld_config
start_config
