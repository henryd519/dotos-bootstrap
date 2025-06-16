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