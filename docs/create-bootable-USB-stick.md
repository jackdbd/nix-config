# Create a bootable USB stick containing NixOS

## 1. Format a USB stick

Use a 4GB (or bigger) USB stick and format it to FAT32 with a program like `fdisk` or GParted.

## 2. Download NixOS

Download the latest **NixOS Graphical ISO image** from the [official website](https://nixos.org/download/).

## 3. Create a bootable USB stick with ddrescue

Take note of the device name of your USB stick.

```sh
sudo fdisk -l
```

Let's say the device name is `/dev/sda` and that the ISO you have downloaded is called `nixos-gnome-24.05.1634.938aa157bbd6-x86_64-linux.iso`. You can now create a bootable USB stick with `ddrescue`.

```sh
sudo ddrescue nixos-gnome-24.05.1634.938aa157bbd6-x86_64-linux.iso /dev/sda --force -D
```

Insert the USB stick into your laptop, keep pressing F12 until you see a boot menu, select the option that boots your system from the USB stick.
