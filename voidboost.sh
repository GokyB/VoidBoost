#! /bin/bash

#Introduction
echo "Welcome to the VoidBoost."

sleep 1

echo "Enabling the nonfree and multilib repositories..."
sudo xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree dbus xorg
sudo ln -S /etc/sv/dbus /var/service

sleep 1

echo "Installing Pulseaudio."
sudo xbps-install -Sy pulseaudio alsa-plugins-pulseaudio
sudo ln -S /etc/sv/pulseaudio /var/service

sleep 1

echo "Please select a desktop enviroment"
echo 
echo "1) Gnome: Installs the Gnome desktop and enables GDM as the login manager."
echo "2) KDE: Installs the KDE Plasma desktop and enables SDDM as the login manager."
echo "3) XFCE: Installs the XFCE4 desktop and enables Lightdm as the login manager."
read -p ":" DE

case $DE in
    [1])
        sudo xbps-install -Sy gnome gnome-apps gdm && sudo ln -S /etc/sv/gdm /var/service/
        ;;
    [2])
        sudo xbps install -Sy kde5 plasma-desktop sddm && sudo ln -S /etc/sv/sddm /var/service/
        ;;
    [3])
        sudo xbps-install -Sy xfce4 xfce4-screensaver xfce4-session xfce4-terminal lightdm-gtk-greeter && sudo ln -S /etc/sv/lightdm var/service/
        ;;
    *)
        echo "Please enter a correct input."
        ;;
esac

sleep 1

echo "Your desktop environment has been successfully installed."

echo

echo "Please select the graphic card that you are using"
echo
echo "1) Intel"
echo "2) AMD"
echo "3) Nvidia(Proprietary)"
echo "4) Nvidia(Nouveau)"
read -p ":" GPU

case $GPU in 
    [1])
        sudo xbps-install -Sy vulkan-loader mesa-vulkan-intel intel-media-driver intel-video-accel
        ;;
    [2])
        sudo xbps-install -Sy vulkan-loader mesa-vulkan mesa-vaapi mesa-vdpau
        ;;
    [3])
        sudo xbps-install -Sy nvidia nvidia-libs-32bit nvidia-settings
        ;;
    [4])
        sudo xbps install -Sy nouveau mesa-dri mesa-dri-32bit nvidia-settings
        ;;
    *)
        echo "Please enter a valid driver."
        ;;
esac

sleep 1

echo "Your drivers have been succesfully installed."
