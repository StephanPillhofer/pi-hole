#!/usr/bin/env bash

# Configure networking via dhcpcd
setDHCPCD() {
    IPV4_ADDRESS="192.168.1.23/24"
    # Check if the IP is already in the file
    staticIpConfig=$(cat ./dummy.conf)
    regex="^[ \t]*static ip_address[ \t]*=[ \t]*${IPV4_ADDRESS}$"
    if grep -q "${regex}" ./dummy.conf; then
        printf "  %b Static IP already configured\\n"
    # If it's not,
    else
        # we can append these lines to dhcpcd.conf to enable a static IP
        echo "interface 192.168.1.23/24
        static ip_address=192.168.1.23/24
        static routers=192.168.1.23/24
        static domain_name_servers=192.168.1.23/24 192.168.1.23/24" | tee -a ./dummy.conf >/dev/null
        printf "  %b Done!\\n"
    fi
}

setDHCPCD
