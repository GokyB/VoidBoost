#! /bin/bash

#Introduction
echo "Welcome to the VoidBoost."

sleep 3

echo "Enabling the nonfree and multilib repositories..."
sudo xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree dbus xorg
sudo ln -S /etc/sv/dbus /var/service

sleep 3

echo "Installing Pulseaudio."
sudo xbps-install -Sy pulseaudio alsa-plugins-pulseaudio
sudo ln -S /etc/sv/pulseaudio /var/service

sleep 3

read -p  "Please select a desktop enviroment (gnome/kde/xfce): " DE
case $DE in
    [gGnNoOmMeE])
        sudo xbps-install -Sy gnome gnome-apps gdm && sudo ln -S /etc/sv/gdm /var/service/
        ;;
    [kKdDeE])
        sudo xbps install -Sy kde5 plasma-desktop sddm && sudo ln -S /etc/sv/sddm /var/service/
        ;;
    [xXfFcCeE])
        sudo xbps-install -Sy xfce4 xfce4-screensaver xfce4-session xfce4-terminal lightdm-gtk-greeter && sudo ln -S /etc/sv/lightdm var/service/
        ;;
    *)
        echo "Please enter a correct input."
        ;;
esac

sleep 3

echo "Your desktop environment has been successfully installed."

echo ""

echo "Please select the graphic card that you are using (intel/amd/nvidia): " GPU
case $GPU in 
    [iIİnNtTeElL])
        sudo xbps-install -Sy vulkan-loader mesa-vulkan-intel intel-media-driver intel-video-accel
        ;;
    [aAmMdD])
        sudo xbps-install -Sy vulkan-loader mesa-vulkan mesa-vaapi mesa-vdpau
        ;;
    [nNvViIİddiIİa])
        sudo xbps-install -Sy nvidia nvidia-libs-32bit nvidia-settings
        ;;
    *)
        echo "Please enter a valid driver."
        ;;
esac

sleep 3

echo "Your drivers have been succesfully installed."
