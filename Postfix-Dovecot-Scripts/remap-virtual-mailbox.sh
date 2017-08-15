#!/bin/bash
sudo postmap /etc/postfix/virtual
sudo systemctl restart postfix