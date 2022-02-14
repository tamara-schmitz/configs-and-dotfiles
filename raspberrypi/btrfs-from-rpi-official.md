Creative Commons License
This work by Tamara Schmitz is licensed under a Creative Commons Attribution 4.0 International License.

# How to BTRFS with RaspberryPi OS Buster

## Enable kernel support
Need to create and enable an initramfs in order to add BTRFS kernel mount support.

First off install these packages now.

`apt update && apt install initramfs-tools btrfs-progs btrfsmaintenance snapper`

Add btrfs module to initramfs:
`echo "btrfs" >> /etc/initramfs-tools/modules`

In /etc/default/raspberrypi-kernel uncomment INITRD=yes but NOT RPI_INITRD=yes.

Append to /boot/config.txt: `initramfs initrd.img followkernel`

Script based on https://k1024.org/posts/2021/2021-01-25-raspbian-with-initrd/
Leave the script as is if you have a RPi 4, if not adjust it based on the ending of your kernel version number from `uname -a`.
If you have an ARMv6 RPi like the Zero or my Model B like though, change the if line to `if [[ "$ABI" != *-v* ]]; then`.

```bash
#!/bin/bash

ABI="$1"
INITRD="$2"
BOOTDIR="$(dirname "$INITRD")"

# Note: the match below _must_ be synced with the boot kernel
if [[ "$ABI" == *-v8+ ]]; then
        echo "Building v8l+ image, updating top initrd"
        cp -p "$INITRD" "$BOOTDIR/initrd.img"
fi
```

Build an initramfs (only required first time):
`update-initramfs -vu -k $(uname -r)`

Reboot and check if the btrfs module is loaded `grep btrfs /proc/modules`

Good, ready to proceed

## Convert to BTRFS

*potential for improvement here: create subvolumes for various directories under root to keep from being snapshotted*

Power off the Pi, insert its SD card into your linux computer.

Convert the ext4 partition to Btrfs. This is reversible! Give it some time.

`btrfs-convert /dev/sdX2`

Once the conversion has finished, look at the output: Under *Target filesystem* you can find the partition's UUID. Copy it.

Mount the boot partition. Replace X with whatever letter your SD card was assigned. Check this using `lsblk` or `df -Th`.

`mount /dev/sdX1 /mnt`

Edit the *cmdline.txt* file on the boot partition. Replace whatever is listed as the *root* variable with `root=UUID=xxxx` where xxxx represents the UUID you just copied. Also change *rootfstype* with `rootfstype=btrfs`.

Unmount the boot partition:

`umount /dev/sdX1`

Next we need to make some changes to the Btrfs filesystem. So let's mount that next.

`mount /dev/sdX2 /mnt`

By default, a swapfile is mounted using dphys-swapfile. This will probably fail due to some properties of the Btrfs filesystem. We need to create a subvolume for this case and set some special flags to allow for compatibility:

```bash
btrfs subvolume create /mnt/swap
mount /dev/sdX2 /mnt/swap -o subvol=swap
truncate -s 0 /mnt/swap/swap # shrink to zero
chattr +C /mnt/var/swap # disable CoW
btrfs property set /mnt/var/swap compression none # disable compression
```
Let's tell dphys-swapfile about our new file location. Edit `/etc/dphys-swapfile`, uncomment *CONF_SWAPFILE* and set the path to `/swap/swap`.

Also we need to adjust the fstab so that the partition can be properly mounted in the later boot process. Edit the file */mnt/etc/fstab* and navigate to the line that mounts */*.
Replace the *PARTUUID* with the root's *UUID*. You can find it out using `blkid /dev/sdX2`. Replace *ext4* with *btrfs*. Set the last number from *1* to *0*.
The root line in fstab should look something like this:
`UUID=XXXX  /  btrfs  defaults,noatime  0  0`
Copy this line and edit it so that we can mount our swapfile subvolume and snapshots for snapper:
`UUID=XXXX  /swap  btrfs  subvol=swap  0  0`
`UUID=XXXX  /.snapshots  btrfs  subvol=.snapshots  0  0`


Ok. Now unmount and hope that it boots ;)

Did everything go well? Great!

Login, and check that swap works using `cat /proc/swaps`. It should list our swap file and its size.
Finally we can free up some space by removing the old ext4 data: `btrfs subvolume delete /ext2_saved`
And here are some other optional things to do:
- set up snapper so that rootfs snapshots are created during updates: `snapper create-config /`
- run a true fs check every month. this will read the entire disk and slow your system down: `systemctl enable btrfs-scrub.timer`


But oh no it doesn't boot? Well here are things you can do.

First of all connect a monitor or serial terminal to the Pi in order to see what it's doing and read the kernel output. If you get so far to see an emergency shell, try exploring that.

For example the first time I tried this, the boot failed unable to mount the rootfs. Using `dmesg | grep -i UUID` I found out the issue: my cmdline said *root=xxx* instead of *root=UUID=xxx*

If all fails either recover from your recovery image or revert back to the previous filesystem using `btrfs-convert /dev/sdX2`.

