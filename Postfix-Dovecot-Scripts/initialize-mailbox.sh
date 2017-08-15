#!/bin/bash
echo "Username: "
read username

echo 'init' | mail -s 'init' -Snorecord $username