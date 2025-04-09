#!/bin/bash

cd
#Installation
echo "It's for Ubuntu 22.04 jammy"
echo '---------------------------------------------------------------'
sleep .5
sudo apt -y update && sudo apt -y upgrade && sudo apt autoremove
sudo apt -y install apt-transport-https ca-certificates wget gnupg
sudo install -m 0755 -d /etc/apt/keyrings && \
    wget -qO- https://repos.ripple.com/repos/api/gpg/key/public | \
    sudo gpg --dearmor -o /etc/apt/keyrings/ripple.gpg
gpg --show-keys /etc/apt/keyrings/ripple.gpg
echo "deb [signed-by=/etc/apt/keyrings/ripple.gpg] https://repos.ripple.com/repos/rippled-deb jammy stable" | \
    sudo tee -a /etc/apt/sources.list.d/ripple.list
echo "install ripple"
echo '--------------------------------------------------------------'
sleep .5
sudo apt -y update && sudo apt -y install rippled
systemctl status rippled.service
sudo systemctl start rippled.service
echo '--------------------------------------------------------------'
echo "allow rippled to bind to privileged ports"
sudo setcap 'cap_net_bind_service=+ep' /opt/ripple/bin/rippled
echo '--------------------------------------------------------------'
echo "ulimit -c unlimited"
echo "You have to edit by youself"
echo "[Service]
LimitCORE=infinity"
echo "You have one sec to copy it"
sleep 1
sudo systemctl edit rippled