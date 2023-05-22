#!/bin/bash
#
# Cameron's Amazing Github sharepoint tool
# 5/20/2023
# This takes files from github downloads them moves them to the one drive folder and then syncs changes
# This tool is only tested on ubuntu 22.04 and the username is user 
# Usage ./run.sh
#
# This part is for first run to install the requiremtns
#
# sudo apt update -y
# sudo apt upgrade -y
# sudo apt install onedrive -y
# type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
# curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
# && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
# && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
# && sudo apt update \
# && sudo apt install gh -y
#
# Remove the old files from last sync
echo "Starting Cameron's Amazing Github to Sharepoint tool"
sleep 1
echo "Removeing old files"
rm -rf /home/user/Omahait
# Clone all the repos in the Omahait comany
echo "cloning all the things"
gh repo list omahait --limit 1000 | while read -r repo _; do
    gh repo clone "$repo" "$repo"
# Stop the cloning loop after all are cloned
done
# Remove all the files in the onedrive sync filder
echo "Removing old files from onedrive folder"
rm -rf /home/user/OneDrive/*
# Move all files to the onedrive folder from the Github Download Folder
echo "Moving files from github folder to onedrive folder"
mv -f /home/user/Omahait/* /home/user/OneDrive/
# Run OndeDrive sync
echo "syncing to onedrive"
onedrive --synchronize
# Let the user know it is done
echo "Cameron's Amazing Github to Sharepoint tool has completed"
sleep 1