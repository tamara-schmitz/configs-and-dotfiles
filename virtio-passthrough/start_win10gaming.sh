#!/bin/sh

# At the moment 1GB hupepages are statically allocated using the following kernel parameters:
# default_hugepagesz=1G hugepagesz=1G hugepages=17 transparent_hugepage=never

## Trap Ctrl+c and activate main display
trap ctrl_c INT

function ctrl_c() {
    ## Activate main display
	echo "Activating main display"
    xrandr --output HDMI2 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output VGA1 --mode 1680x1050 --pos 1920x30 --rotate normal
	exit 0
}


## Start VM. Ask for root access using sudo
#su -c 'virsh start win10-nvidia && virt-viewer win10-nvidia'
#sudo sh -c "echo 8100 > /proc/sys/vm/nr_hugepages" # allocate 2MB hugepages
sudo sh -c "echo 16 > /sys/devices/system/node/node0/hugepages/hugepages-1048576kB/nr_hugepages && mkdir /dev/hugepages1G && mount -t hugetlbfs -o pagesize=1G none /dev/hugepages1G" # allocate 1GB hugepages

#sudo virsh start win10-nvidia
sudo virsh start win10-gaming	


## Keep main monitor deactivated
while true; do
	sleep 10
	xrandr --output HDMI2 --off --output HDMI1 --off --output VIRTUAL1 --off --output VGA1 --primary --mode 1680x1050 --pos 1920x30 --rotate normal
	# Check if running
	# tmp=$(sudo virsh list --all | grep " win10-nvidia " | awk '{ print $3}')
	tmp=$(sudo virsh list --all | grep " win10-gaming " | awk '{ print $3}')
	if ([ "$tmp" != "running" ])
	then
		echo "VM no longer running"
		# dealloc hugepage memory
		#sudo sh -c "echo 0 > /proc/sys/vm/nr_hugepages" # 2MB hugepages
		sudo sh -c "echo 0 > /sys/devices/system/node/node0/hugepages/hugepages-1048576kB/nr_hugepages" # 1GB hugepages

		ctrl_c # exit
	fi
done
