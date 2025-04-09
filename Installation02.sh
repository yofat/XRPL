#!/bin/bash

echo "After you edit by youself"
echo "---------------------------------------------------"
gdb /opt/ripple/bin/rippled /var/lib/apport/coredump/core
echo "---------------------------------------------------"
rippled server_info