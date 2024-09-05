#!/usr/bin/env bash

sudo cp -r * /etc/nixos/
sudo nixos-rebuild switch --upgrade --flake /etc/nixos/
