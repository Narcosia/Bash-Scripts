#!/bin/bash

echo "Enter username"

read USERNAME

# Replace "server-name" with your FQDN
CLIENTNAME="server-name-$USERNAME"
echo "Creating ${CLIENTNAME}"

sudo docker run -v ovpn-data:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass

sudo docker run -v ovpn-data:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn


# Use this to replace the server-name with anIP address if necessary. This will change the IP address on the ovpn config file.
#sed -i -ed 's/server-name/10.1.1.1/g' $CLIENTNAME.ovpn
