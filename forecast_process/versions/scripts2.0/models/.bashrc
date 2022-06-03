# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

#  conda initialize
__conda_setup="$('/root/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "/root/anaconda3/etc/profile.d/conda.sh" ]; then
		. "/root/anaconda3/etc/profile.d/conda.sh"
	else
		export PATH="/root/anaconda3/bin:$PATH"
	fi
fi
# unset conda

export PATH=/root/anaconda3/bin:/root/anaconda3/bin:/forecast/models/CPT/17.6.1/bin:/forecast/models:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
