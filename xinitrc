# vim: ft=sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
export GTK_IM_MODULE=ibus
export XMODIFIERS="@im=ibus"
export QT_IM_MODULE=ibus
ibus-daemon -drx
xcompmgr &
feh --bg-fill --randomize ~/.wallpapers
# Make Gtk applications, e.g. gvim follow fontconfig settings.
xsettingsd &
VBoxClient-all &
exec i3
