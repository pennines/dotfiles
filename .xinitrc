xrdb ~/.Xresources &
picom &
xset r rate 190 45 &
~/.fehbg &
# hsetroot -solid #202020 &
xsetroot -cursor_name left_ptr &
xinput set-prop "Logitech Gaming Mouse G303" "libinput Accel Speed" -1 &
xinput disable "Synaptics TM3075-002" &
redshift &
dunst &
exec xmonad
