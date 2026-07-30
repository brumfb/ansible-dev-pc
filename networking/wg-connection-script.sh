#!/usr/bin/env bash
# https://www.reddit.com/r/Ubiquiti/comments/1ewan95/wireguard_vpn_setup_on_ubuntu_2404/

# Installing WireGuard
sudo apt-get update && sudo apt-get install wireguard -y

# Create WireGuard profile on UDM, download, and apply changes
# (Manual step)

# Copy the WireGuard profile to the WireGuard folder
sudo cp "~/Downloads/VPNServerWireGuard-Client.conf"/etc/wireguard/wg0.conf

# Make the WireGuard profile unavailable to 'everyone'
sudo chmod go-r /etc/wireguard/wg0.conf

# Import the WireGuard profile for NetworkManager
sudo nmcli connection import type wireguard file /etc/wireguard/wg0.conf

# Un-tick "Make available to other users"
nmcli connection modify wg0 connection.permissions user:$(whoami)

# Verifying Permissions, you can check what permissions are set by running
nmcli connection show wg0 | grep permissions

# Optionally rename the connection to something less cryptic
sudo nmcli connection modify wg0 connection.id "Home VPN (WG)"

# Inspect Connection Details, especially the 'permissions' line
nmcli connection show "Home VPN (WG)"

# --------------------
# Show All Connections
nmcli connection show
