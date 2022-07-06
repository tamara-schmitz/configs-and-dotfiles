I used to run Windows in a VM using a mechanism known as VFIO passthrough from
2015 up until December 2018. I switched away from it due to its issues with VR gaming.
Looking Glass was in development around that time but I never ended up trying it
back then.

This folder contains the libvirt XML of the virtual I used, as well as the start
script I would always launch whenever I wanted to use the VM.

I do not recall what got me into doing this, but when I built my computer in
2015, I planned for VFIO by getting a higher end CPU and picking a motherboard
that played nice.
The hardware was an Intel Z97 platform with an i7 4790k and later 32GB RAM using
Intel HD graphics for Linux and passing through an NVIDIA GTX 970 graphics card.

This many part guide was definitely a vital component to help me get the
setup running: http://vfio.blogspot.com/2015/05/vfio-gpu-how-to-series-part-1-hardware.html

I already had this set up and running before Wendell from Level1Techs made his first YouTube video about
the topic in September 2015: https://www.youtube.com/watch?v=16dbAUrtMX4

Here are some bookmarks that helped me back then.
http://vfio.blogspot.com/2015/05/vfio-gpu-how-to-series-part-4-our-first.html?m=1
https://linux.web.cern.ch/centos7/docs/rhel/Red_Hat_Enterprise_Linux-7-Virtualization_Tuning_and_Optimization_Guide-en-US.pdf
https://docs.fedoraproject.org/en-US/Fedora/13/html/Virtualization_Guide/ch25s06.html
http://www-01.ibm.com/support/knowledgecenter/linuxonibm/liaat/liaatbestpractices_pdf.pdf
