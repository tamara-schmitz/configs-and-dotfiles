# Sample .profile for SUSE Linux
# rewritten by Christian Steinruecken <cstein@suse.de>
#
# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
# This overwrites the system default set in /etc/sysconfig/language
# in the variable RC_LANG.
#
#export LANG=de_DE.UTF-8	# uncomment this line for German output
#export LANG=fr_FR.UTF-8	# uncomment this line for French output
#export LANG=es_ES.UTF-8	# uncomment this line for Spanish output
export LANG=en_GB.UTF-8		# uncomment this line for English UK output

force_color_prompt=yes

# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)
#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi
export GPG_TTY=$(tty)

eval `ssh-agent`

source ~/.alias

tmux new-session -d -s "nvidia-power" ~/bin/nvidia-powermode.sh 2>/dev/null

#xscreensaver &
