Creative Commons License
This work by Tamara Schmitz is licensed under a Creative Commons Attribution 4.0 International License.

# How to F2FS with RaspberryPi OS Buster

There is no direct conversion process from ext4 like with btrfs. So we need to
copy the files over to another medium, reformat the root partition on the SD card and copy the files back.

## Copy Data

You need to copy the data to another medium with a filesystem that supports Unix
attributes like ext4, btrfs, f2fs, xfs etc.

Power off the Pi, insert its SD card into your linux computer.

Mount the Pi SD card on your machine. Then rsync the data to your computer

`mkdir ~/pi-backup && sudo rsync -avxP /run/media/user/pi /home/user/pi-backup`

## Reformat as F2FS

Before you reformat the partition, make sure that your host OS' kernel version
is the same or older than Raspberry Pi OS' version! According to Arch wiki it
can cause problems, if you format the partition on a newer system. Check kernel
versions using `uname -a`.

Since the OS is Debian based you could install set up a VM with that specific
Debian version.

Reformat the partition:

`mkfs.f2fs -O extra_attr,inode_checksum,sb_checksum /dev/sdX2`

Once the formatting has finished, look at the output: Under *Target filesystem* you can find the partition's UUID. Copy it.

Mount the boot partition. Replace X with whatever letter your SD card was assigned. Check this using `lsblk` or `df -Th`.

`mount /dev/sdX1 /mnt`

Edit the *cmdline.txt* file on the boot partition. Replace *rootfstype* with `rootfstype=f2fs`.

Unmount the boot partition:

`umount /dev/sdX1`

Next we need to make some changes to the F2FS filesystem. So let's mount that next.

`mount /dev/sdX2 /mnt`

Rsync the data onto the F2FS filesystem:

`sudo rsync -avxP /home/user/pi-backup /mnt`

Adjust the fstab so that the partition can be properly mounted in the later boot process. Edit the file */mnt/etc/fstab* and navigate to the line that mounts */*.
Replace *ext4* with *f2fs* and add these flags: `defaults,whint_mode=fs-based,lazytime`.
The root line in fstab should look something like this:
`PARTUUID=XXXX-02  /  f2fs  defaults,whint_mode=fs-based,lazytime  0  1`

Ok. Now unmount and hope that it boots ;)

Did everything go well? Great!

Login, and check that swap works using `cat /proc/swaps`. It should list our swap file and its size.

But oh no it doesn't boot? Well here are things you can do.

First of all connect a monitor or serial terminal to the Pi in order to see what it's doing and read the kernel output. If you get so far to see an emergency shell, try exploring that.

For example the first time I tried this, the boot failed unable to mount the rootfs. Using `dmesg | grep -i UUID` I found out the issue: my cmdline said *root=xxx* instead of *root=UUID=xxx*
