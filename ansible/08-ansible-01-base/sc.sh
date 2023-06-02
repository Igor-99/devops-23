#!/usr/bin/env bash

sudo docker-compose -f docker-compose.yml up -d
sudo ansible-playbook -i playbook/inventory/prod.yml playbook/site.yml --ask-vault-pass
sudo docker-compose down -t 1
