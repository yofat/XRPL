#!/bin/bash

echo "install clio"
echo "----------------------------------------------------------------"
sleep .5
cd
sudo apt -y install clio
cd /opt/clio
sudo mkdir etc
cd etc
echo "----------------------------------------------------------------"
echo "than You have to edit by yourself"
echo "----------------------------------------------------------------"
echo '"etl_sources":
[
    {
        "ip":"127.0.0.1",
        "ws_port":"6005",
        "grpc_port":"50051"
    }
]'
echo "----------------------------------------------------------------"
echo "You have one sec to copy it"
sleep 1
sudo nano config.json
