# ~/.bashrc: executed by bash(1) for non-login shells.
#  conda initialize
__conda_setup="$('/root/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
	echo "entro en if 1"
	eval "$__conda_setup"
else
	if [ -f "/root/anaconda3/etc/profile.d/conda.sh" ]; then
		echo "entro en if 2"
		. "/root/anaconda3/etc/profile.d/conda.sh"
	else
		echo "entron en if 3"
		export PATH="/root/anaconda3/bin:$PATH"
	fi
fi

# unset conda
export PATH=/root/anaconda3/bin:/root/anaconda3/bin:/forecast/models/CPT/17.6.1/bin:/forecast/models:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
