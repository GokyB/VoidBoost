import subprocess
import os


sysinfo = subprocess.run("uname -a", shell=True,
stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)


def isRoot():
    os.getuid() == 0


def xbps(pkg):
    subprocess.run(f"sudo xbps-install -Sy {pkg},", shell=True,
    stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)


def nvidiaProprietary():

    devicelist = """
    1 - Nvidia 400/500 series
    2 - Nvidia 600/700 series
    3 - Nvidia 800+ series
    """


    choice = {
        "1": "nvidia390",
        "2": "nvidia470",
        "3": "nvidia"
    }

    selection = input("\n: ")

    try:
        xbps(choice[selection])
    except KeyError():
        print("Please enter a valid input(1 - 3)")
        nvidiaProprietary()


def drivers():
    driverlist = """
    1 - Nvidia: Proprietary Driver
    2 - Nvidia Nouveau - Open source driver
    3 - AMD/ATI
    4 - Intel
    """

    selection = input("\n: ")

    choice = {
        "1" : nvidiaProprietary(),
        "2" : "mesa-dri xf86-video-nouveau",
        "3" : "mesa-dri vulkan-loader mesa-vulkan-radeon amdvlk mesa-vaapi mesa-vdpau",
        "4" : "mesa-vulkan-loader mesa-vulkan-intel intel-video-accel"
    }

    try:
        xbps(choice[selection])
    except KeyError():
        print("\nPlease enter a valid input")

def desktop():
    desktoplist = """
    1 - XFCE4
    2 - KDE Plasma
    3 - Gnome
    4 - MATE
    5 - LXDE
    6 - LXQT
    7 - Cinnamon
    8 - İ3
    9 - Budgie
    10 - Enlightenment
    """

    print(desktoplist)

    selection = input("\n: ")

    choice = {
        "1" : "xfce4 xfce4-panel",
        "2" : "kde5 kde5-baseapps",
        "3" : "gnome gnome-apps gnome-common",
        "4" : "mate mate-desktop mate-common mate-extra",
        "5" : "lxde lxde-common lxde-icon-theme lxpanel",
        "6" : "lxqt lxqt-panel lxqt-qtplugin lxqt-themes",
        "7" : "cinnamon-all",
        "8" : "i3 i3status",
        "9" : "budgie-desktop",
        "10" : "enlightenment e16 efl"
    }

    try:
        xbps(choice[selection])
    except KeyError():
        print("Please enter a valid input")
        desktop()

def loginManager():
    lmlist = """
    1 - SDDM
    2 - GDM
    3 - Lightdm
    """

    selection = input(lmlist, "\n: ")

    choice = {
        "1" : xbps("sddm"),
        "2" : xbps("gdm"),
        "3" : xbps("lightdm-gtk-greeter")
    }

    choice.get(selection, "Please enter a valid input")

def homepage():
    banner = """
    							            ,,           
				      ,,,,,,,,,,,,,,.    
				        ,        ,,,,,,  
				 *(((               ,,,, 
				 ((((     ,,,,,,     ,,,,
				/(((     ,,,,,,,,    ,,,,
				 ((((     ,,,,,,     ,,,,
				 ,((((               ,,, 
				   ((((((        (       
				     .((((((((((((((     


            __   __ _______ ___ ______  _______ _______ _______ _______ _______ 
            |  | |  |       |   |      ||  _    |       |       |       |       |
            |  |_|  |   _   |   |  _    | |_|   |   _   |   _   |  _____|_     _|
            |       |  | |  |   | | |   |       |  | |  |  | |  | |_____  |   |  										
            |       |  |_|  |   | |_|   |  _   ||  |_|  |  |_|  |_____  | |   |  
             |     ||       |   |       | |_|   |       |       |_____| | |   |  
              |___| |_______|___|______||_______|_______|_______|_______| |___|  
    """

    print(banner)

    print("Checking repositories\n")

    packages = subprocess.run("sudo xbps-query", shell=True)
    
    if "void repo nonfree\nvoid-repo-multilib\nvoid-repo-multilib-nonfree" not in packages:
        print("Enabling the multilib packages\n")
        xbps("void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree")
    else:
        pass

    if "dbus\nxorg" not in packages:
        print("Installing and enabling dbus and xorg.")
        subprocess("sudo xbps-install -Sy dbus xorg && sudo ln -s /etc/sv/dbus /var/service/ && sudo ln -s /etc/sv/xorg /var/service/",
        shell=True, stdout = subprocess.DEVNULL, stderr = subprocess.STDOUT)
    else:
        pass

    menu = """
    1 - Drivers
    2 - Desktop Environments
    3 - Login Managers
    4 - Quit and reboot
    """

    print(menu)
    selection = input(": ")

    choice = {
        "1" : drivers(),
        "2" : desktop(),
        "3" : loginManager(),
        "4" : "quit"
    }

    res = choice.get(selection, "Wrong input, please enter a valid input")

    if res == "Wrong input, please enter a valid input":
        homepage()
    if res == "4":
        print("Quitting...")
        subprocess.run("sudo reboot", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
        break