dwm-install:
	mkdir -p ~/.config/suckless
	git clone https://git.suckless.org/dwm ~/.config/suckless/$1
	cd ~/.config/suckless/dwm
	make install

dwm-config:
	echo "stow suckless"
	stow -D suckless
	stow suckless

dwm-setup: dwm-install dwm-pre-setup dwm-config
	cp ./startdwm /usr/local/bin
	chmod +x /usr/local/bin/startdwm

dwm-pre-setup:
	rm -rf ~/.config/suckless/config.h ~/.config/suckless/dwm.1 ~/.config/suckless/dwm.c ~/.config/suckless/dwm.c.orig ~/.config/suckless/patches

install-st:
	git clone https://git.suckless.org/st ~/.config/suckless/$1
	cd ~/.config/suckless/st
	make install

setup: dwm-setup

.PHONY: dwm-setup setup
