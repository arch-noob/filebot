#!/bin/bash

# Define the URL for the update.xml file
UPDATE_URL="https://app.filebot.net/update.xml"

# Fetch the latest version from update.xml
latest_version=$(wget -qO- "$UPDATE_URL" | grep -oP '(?<=<name>FileBot ).*(?=</name>)')

if [ -z "$latest_version" ]; then
  echo "Error: Could not find the latest version in update.xml."
  exit 1
fi

# Define the PKGBUILD file
PKGBUILD="PKGBUILD"

# Update only the pkgver in PKGBUILD
sed -i "s/^pkgver=.*/pkgver=$latest_version/" "$PKGBUILD"

# Update checksums
updpkgsums

# Install
makepkg -si
