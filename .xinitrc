#!/bin/sh

# We are using xinit-xsession package to use .xinitrc as the sesssion configuration
# xinitrc also runs automatically when startx is run.

# . ~/.xprofile

XDG_CACHE_HOME="${HOME}/.cache"

# We need quotes to preserve multiline output
PID_NAMES="$(ps -C xcompmgr,dunst,mpd,unclutter,dwm)"

# START_XCOMPMGR=0
# START_DUNST=0
# START_MPD=0
# START_UNCLUTTER=0
START_DWM=0

# If no colors are cached just run setbg command
setbg "${HOME}/.local/share/bg"

# If process name doesn't already exist, start it.
# This is useful if making changes to this script and logging out is too excessive...
if ! $(echo -n "${PID_NAMES}" | grep -q "xcompmgr"); then
    xcompmgr &  # For transparency
fi

if ! $(echo -n "${PID_NAMES}" | grep -q "dunst"); then
   dunst &      # Notifications
fi

if ! $(echo -n "${PID_NAMES}" | grep -q "mpd"); then
    mpd &       # Music Player Daemon
fi

if ! $(echo -n "${PID_NAMES}" | grep -q "unclutter"); then
    unclutter & # Remove mouse when it's idling
fi

if ! $(echo -n "${PID_NAMES}" | grep -q "dwm"); then
    START_DWM=1 # DWM
fi


xset r rate 300 55 &    # Speed xrate up
remaps &        # run the remaps script, switching caps/esc and more; check it for more info
lxpolkit & # Run a polkit daemon

# Ensure the dbus environment is running properly
systemctl --user import-environment DISPLAY XAUTHORITY

if which dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# Start a LIBRESPOT speaker
# librespot --name "LIBRESPOT" --device-type computer -b 320 -u "schoudorff@gmail.com" -p "Inabottle11!" --initial-volume 100 &

keyledsd -c /home/mathias/.config/keyledsd.conf &

exec dbus-launch \
    --exit-with-session \
    --sh-syntax \
    --autolaunch=$(cat /var/lib/dbus/machine-id) \
    ssh-agent \
    dwm

