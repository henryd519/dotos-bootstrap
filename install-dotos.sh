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
  iwd \
  networkmanager \
  unzip


echo "Enabling iwd and NetworkManager for Wi-Fi connectivity..."
sudo systemctl enable iwd
sudo systemctl start iwd
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager


echo "Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh
export PATH="$HOME/.ollama/bin:$PATH"
ollama pull nousresearch/nous-hermes-2-mistral

echo "Setting up DotOS interface commands..."
mkdir -p ~/bin

cat << 'EOF' > ~/bin/think
#!/bin/bash
echo "Starting LLM..."
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

cat << 'EOF' > ~/bin/help
#!/bin/bash
echo "DotOS Commands"
echo "think     → Start your LLM (Dominium)"
echo "browse    → Launch browser (Orbis)"
echo "wifi      → Open Wi-Fi menu"
echo "help      → Show this help menu"
echo "DotOS: Dominium. Orbis. Temperantia."
echo "This machine offers only two tools: a mind and a window."
echo "No more. No less."
EOF
chmod +x ~/bin/help


echo "Adding DotOS command aliases to .bashrc..."
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc

echo "Enforcing Temperantia: Blocking new installs..."
echo 'alias pacman="echo Temperantia: Nothing else."' >> ~/.bashrc

echo "DotOS bootstrap complete. Log out and back in, or run: source ~/.bashrc"
echo -e "\nTry: think   | browse   | wifi   | help"
