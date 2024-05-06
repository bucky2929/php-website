#!/bin/bash
# Change the ownership and permissions of the web directory
chown -R apache:apache /var/www/html/
chmod -R 755 /var/www/html/
