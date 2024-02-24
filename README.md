"# dotfiles"

## DWM

### Easy installation

Declare a function to install suckless tools

```bash
function suckless() {
    git clone https://git.suckless.org/$1 ~/.config/suckless/$1
    cd ~/.config/suckless/$1
    sudo make clean install
}
```

Then, you can install dwm with the following command:

```bash
sudo suckless dwm
```

### DMenu

```bash
sudo suckless dmenu
```

Some references:
- [Best Practices for DWM](https://www.troubleshooters.com/linux/dmenu/bestpractices.htm)
