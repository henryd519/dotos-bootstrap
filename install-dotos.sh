#!/bin/bash
# Arch bootstrap script
set -e

echo "Updating system packages..."
sudo pacman -Syu --noconfirm

echo "Installing core packages..."
sudo pacman -S --noconfirm \
  base-devel \
  git \
  curl \
  firefox

echo "Setting up networking..."
sudo pacman -S --noconfirm iwd
sudo systemctl enable iwd
sudo systemctl start iwd