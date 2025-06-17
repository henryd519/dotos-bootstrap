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
  firefox \
  linux-firmware \
  intel-ucode \
  iwlwifi \
  iwd \
  networkmanager \
  unzip


echo -e "\n🌐 Enabling iwd and NetworkManager for Wi-Fi connectivity..."
sudo systemctl enable iwd
sudo systemctl start iwd
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager


echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

echo "Setting up CLI..."
mkdir -p ~/bin
cat << 'EOF' > ~/bin/dot
#!/bin/bash
case "$1" in
  llm)
    ollama run phi3
    ;;
  browser)
    firefox
    ;;
  *)
    echo "Usage: dot llm|browser"
    ;;
esac
EOF
chmod +x ~/bin/dot