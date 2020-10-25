#!/usr/bin/sh

test -e "$XDG_RUNTIME_DIR/awesome/autorun/$XDG_SESSION_ID" && exit 0
mkdir -p "$XDG_RUNTIME_DIR/awesome/autorun/$XDG_SESSION_ID"

function run {
  if ! pgrep -f $1 ;
  then
    "$@" &
  fi
}

# Set keyboard repeat delay (how long until start repeating) to 260ms and repeat to 50
run xset r rate 260 50 

unclutter --timeout 3 --exclude-root -b # Don't remove mouse on background, remove it after 3 seconds idle

wal -i "$(< "${HOME}/.cache/wal/wal")" --backend colortheif --saturate 0.4

run picom # Compositor (transparency, blur etc)
run lxpolkit # LXDE Policy Kit daemon
run remaps # Remap some keys
run mpd # Start Music Player Daemon


# Be able to verify ssh when we want to
run ssh-agent
