# RyRadio

Set of scripts to create one-purpose Internet Radio Player from old Raspberry PI with simple Web Interface to change stations and volume. Settings is persistent.

# !!! WARNING !!!

!!! WARNING !!! Security of Apache, PHP and so is ZERO, 0, KEINE, NONE, NINGUNO, NO, 없음 ...
!!! It's supposed to be installed in local home network ONLY
!!! Never publish web interface to internet
!!! This will delete all content of /var/www/html/ !!!

## Getting Started

By default analog output is enabled. Can be changed to HDMI in runAfterBoot.sh script. Radio Stations could be modified in radioStations.php before you run ansible-playbook. After ansible-playbook install, simple WEB interface should be available on http://YOUR_RPI_IP_ADDRESS/.

### Prerequisites

Prepare RPi with new, clean OS Raspbian.
Download RASPBIAN STRETCH LITE from https://www.raspberrypi.org/downloads/raspbian/
Unzip image file and create boot MicroSD/SD card. Example is for MacOS:

```
diskutil list
diskutil unmountDisk /dev/disk<disk# from diskutil>
sudo dd bs=1m if=image.img of=/dev/rdisk<disk# from diskutil> conv=sync
diskutil eject /dev/disk<disk# from diskutil>
```

Steps for Linux will be similar and Windows users can use dd for Windows or any tool to write image to USB disk (SD/MicroSD card).

### Installing

Login as user pi with password raspberry.

```
sudo -i
systemctl enable ssh
systemctl start ssh
```

From remote (Mac/Linux, Windows users use putty):
```
scp -r ryradio/ pi@YOUR_RPI_IP_ADDRESS:
```

Login over SSH.
```
sudo -i
apt update && apt install -y python software-properties-common ansible
cd ryradio && ansible-playbook ryradio.yml
```

Read final MESSAGE section when ansible ends to get email notification work.

## Authors

* **Josef Rysanek** - *Initial work* - [RyRadio]()

## License

This project is licensed under the MIT License.

## Acknowledgments

Thanks Peec for PHP Process class.


