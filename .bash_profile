#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X
# if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#	 exec startx
# fi

export PATH="/home/mathias/.local/share/cargo/bin:$PATH"
