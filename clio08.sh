#!/bin/bash

cd
sudo systemctl enable clio
sudo systemctl start rippled
sudo systemctl start clio
echo "-----------------------------------------------"
echo "finished"