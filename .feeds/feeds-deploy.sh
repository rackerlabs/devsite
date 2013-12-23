#!/bin/bash

# This script assumes you've created this server with a key pair. If you haven't, you're not getting back in.
# curl -sS https://raw.github.com/rackerlabs/devsite/master/.feeds/feeds-deploy.sh | bash

# Lock it down
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
service ssh restart
ufw allow 22
ufw --force enable
apt-get -y install fail2ban

# Upgrade and set unattended upgrades
apt-get -y update; apt-get -y upgrade
apt-get -y install unattended-upgrades
sed -i 's/Download-Upgradeable-Packages "0";/Download-Upgradeable-Packages "1";/g' /etc/apt/apt.conf.d/10periodic
sed -i 's/AutocleanInterval "0";/AutocleanInterval "7";/g' /etc/apt/apt.conf.d/10periodic
echo 'APT::Periodic::Unattended-Upgrade "1";' >> /etc/apt/apt.conf.d/10periodic

# Clone devsite and GitHub config
cd
apt-get -y install git
git clone git@github.com:rackerlabs/devsite.git
git config --global user.name "DRG Bot"
git config --global user.email "sdk-support@rackspace.com"

# Setup Planet Venus (feed aggregator)
cd
apt-get -y install planet-venus
mkdir planet
cd planet
planet --create apis
cp /root/devsite/.feeds/planet-api.ini apis/planet-api.ini
planet --create sdk
cp /root/devsite/.feeds/planet-sdk.ini apis/planet-sdk.ini

# Setup WebPageToAtomFeed
cd
apt-get -y install openjdk-7-jdk maven
git clone https://github.com/rackerlabs/WebPageToAtomFeed.git
cd WebPageToAtomFeed/
cp /root/devsite/.feeds/WebPageToAtomFeed.properties src/main/resources/WebPageToAtomFeed.properties
mvn clean install
mvn exec:java

