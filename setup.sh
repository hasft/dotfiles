zypper in git
zypper in emacs
rm -rf .emacs
git clone https://github.com/hasft/dotfiles.git
cp -rf ./emacs.d/ .
zypper in xorg-x11
zypper in xorg-x11-server
cp /etc/X11/xinit/xinitrc ~/.xinitrc
chmod u+s /usr/bin/Xorg
zypper in i3
zypper in alsa-utils
echo options snd_hda_intel index=1 > /etc/modprobe.d/default.conf
