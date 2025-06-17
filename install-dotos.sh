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
ollama pull nousresearch/nous-hermes-2-mistral

echo -e "Setting up DotOS interface commands..."
mkdir -p ~/bin

cat << 'EOF' > ~/bin/think
#!/bin/bash
echo "Staring LLM..."
ollama run nousresearch/nous-hermes-2-mistral
EOF
chmod +x ~/bin/think

cat << 'EOF' > ~/bin/browse
#!/bin/bash
echo "Starting browser..."
firefox
EOF
chmod +x ~/bin/browse

cat << 'EOF' > ~/bin/wifi
#!/bin/bash
echo "Starting Wi-Fi manager..."
nmtui
EOF
chmod +x ~/bin/wifi