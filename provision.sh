#!/bin/sh

echo 'export TZ="Asia/Tokyo"' >> /etc/environment
apt-get update
apt-get install language-pack-ja -y
