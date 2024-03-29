# RyRadio

Set of scripts to create one-purpose Internet Radio Player from old Raspberry PI with simple Web Interface to change stations and volume. Settings is persistent.

![Web Interface Preview](https://raw.githubusercontent.com/jorycz/ryradio/master/preview/web.png)

# API

* Turn Radio **On**: wget -qO/dev/null http://YOUR_RPI_IP_ADDRESS/rr/index.php?station
* Turn Radio **Off**: wget -qO/dev/null http://YOUR_RPI_IP_ADDRESS/rr/index.php?station=666

# !!! WARNING !!!

!!! Security of Apache, PHP and so is ZERO, 0, KEINE, NONE, NINGUNO, NO, 없음 !  
!!! It's supposed to be installed in local home network ONLY !  
!!! Never publish web interface to internet !  
!!! This will ADD content to /var/www/html/ - rr/ folder with radio files !
I made it in few hours including testing so it should be working fine but scripts are far from perfect. Do NOT run it on other than completelly wiped/clean Raspberry PI.

## Getting Started

By default analog output is enabled. This can be changed to HDMI in **runAfterBoot.sh** script.  
Radio Stations could be modified in **radioStations.php** before you run ansible-playbook.  
After ansible-playbook install, simple WEB interface should be available on http://YOUR_RPI_IP_ADDRESS/rr/.

### Prerequisites

Prepare RPi with new, clean OS Raspbian.  
Download RASPBIAN STRETCH LITE from https://www.raspberrypi.org/downloads/raspbian/  
Unzip image file and create boot MicroSD/SD card.  
Example is for **MacOS**:

```
diskutil list
```
Find what disk# is SD card. You can run above command before and after insert SD card and compare results.
```
diskutil unmountDisk /dev/disk<disk# from diskutil>
sudo dd bs=1m if=image.img of=/dev/rdisk<disk# from diskutil> conv=sync
diskutil eject /dev/disk<disk# from diskutil>
```

Steps for **Linux** will be similar.  
**Windows** users can follow this guide [Installing Raspbian system images using Windows](https://www.raspberrypi.org/documentation/installation/installing-images/windows.md) use Etcher, Win32DiskImager or any tool for writing disk image to USB disk (SD/MicroSD card).

### Install

Login by SSH (Windows users can use putty) as user pi with password raspberry.

```
sudo -i
systemctl enable ssh
systemctl start ssh
apt update && apt install -y python software-properties-common ansible git
exit
git clone https://github.com/jorycz/ryradio.git
cd ryradio
ansible-playbook firstInstall.yml
ansible-playbook updateRadioFiles.yml
// If you don't want to install apache web server and postfix mail server, use:
//   ansible-playbook updateRadioFiles.yml firstInstall.yml --tags radioOnly
// You must have own WEB server with PHP and MAIL server.
```

**Read final MESSAGE section when ansible ends to get email notification work.**

### Update

Login using SSH as user pi with password raspberry.

```
cd ryradio
git pull
ansible-playbook updateRadioFiles.yml
sudo reboot
```

## Authors

* **Josef Rysanek** - *Initial work* - [RyRadio](https://github.com/jorycz/ryradio)

## License

This project is licensed under the MIT License.

## Acknowledgments

Thanks Peec for PHP Process class.

