#!/bin/bash

# İnstalling basic stuff
echo Hello $USER.
echo
echo Installing required programs and libraries:
echo -----------------------------
sudo xbps-install -Syv void-repo-nonfree void-repo-multilib-nonfree lightdm-gtk-greeter lightdm-gtk-greeter-settings libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit
sleep 3

#Lightdm config
echo Configurating the Lightdm service.
rm /var/Service/lxdm && ln -s /etc/sv/lightdm /var/service/
sleep 3

#Driver configuration
echo What brand of gpu are you using? (intel/nvidia)
read answer

if [ $answer = 'intel' ]
then 
sudo xbps-install -Syv mesa-dri mesa-dri-32bit mesa-vulkan-intel mesa-vulkan-intel-32bit libglapi libglapi-32bit libglvnd libva-glx-32bit
fi

if [ $answer = 'nvidia' ]
then
echo Which type of drivers would you like to install?[nouveau/nvidia)
read answer
	if [ $answer = nouveau ]
	then
	sudo xbps-install mesa-dri mesa-dri-32bit xf86-video-nouveau
	
	if [ $answer = nvidia ]
	then
	sudo xbps-install -Syv nvidia nvidia-libs-32bit
	fi

echo Void Boost has finished installing the libraries and drivers.You may now use your system
