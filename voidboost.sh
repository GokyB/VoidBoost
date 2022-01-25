#! /bin/bash

#Introduction
echo "Welcome to the VoidBoost."

wait 3

echo "Enabling the nonfree and multilib repositories..."
sudo xbps-install -Sy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree dbus xorg
sudo ln -S /etc/sv/dbus /var/service

wait 3

echo "Installing Pulseaudio."
sudo xbps-install -S pulseaudio alsa alsa-plugins-pulseaudio
sudo ln -S /etc/sv/pulseaudio /var/service

wait 3

read -p  "Please select a desktop enviroment (gnome/kde/xfce): " DE
case $DE in
    [gGnNoOmMeE])
        sudo xbps-install -S gnome gnome-apps gdm && sudo ln -S /etc/sv/gdm /var/service/
        ;;
    [kKdDeE])
        sudo xbps install -S kde5 plasma-desktop sddm && sudo ln -S /etc/sv/sddm /var/service/
        ;;
    [xXfFcCeE])
        sudo xbps-install -S xfce4 xfce4-screensaver xfce4-session xfce4-terminal lightdm-gtk-greeter && sudo ln -S /etc/sv/lightdm var/service/
        ;;
    *)
        echo "Please enter a correct input."
        ;;
esac

wait 3

echo "Your desktop environment has been successfully installed."

echo ""

echo "Please select the graphic card that you are using (intel/amd/nvidia): " GPU
case $GPU in 
    [iIİ] [nN] [tT] [eE] [lL])
        sudo xbps-install -S vulkan-loader mesa-vulkan-intel intel-media-driver intel-video-accel
        ;;
    [aA] [mM] [dD])
        sudo xbps-install -S vulkan-loader mesa-vulkan mesa-vaapi mesa-vdpau
        ;;
    [nN] [vV] [iIİ] [dD] [iIİ] [aA])
        sudo xbps-install -S nvidia nvidia-libs-32bit nvidia-settings
        ;;
    *)
        echo "Please enter a valid driver."
        ;;
esac

wait 3

echo "Your drivers have been succesfully installed."
