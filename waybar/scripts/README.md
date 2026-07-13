# Make waybar scripts executable
chmod +x ~/.config/waybar/scripts/cava.sh
chmod +x ~/.config/waybar/scripts/powermenu.sh

sudo apt install cava      # Ubuntu
sudo emerge --ask media-sound/cava   # Gentoo

sudo apt install rofi

# Make folders if they dont excist
mkdir -p ~/.config/waybar/scripts
mkdir -p ~/.config/cava
