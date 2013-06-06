# XMonad Configuration

This is intended as a configuration for _XMonad_ for a development
machine. It is intended to support Eclipse, Emacs and a Terminal
running tmux, as well as mail. Some keys are remapped to use the
windows key when possible.

## XMonad

[XMonad](http://xmonad.org) is a window tiling manager. This means
that windows are automatically resized and moved for you.

## Installing XMonad

Assuming the path to this repository is _MONAD_:

1. Grab _xmonad_: `sudo apt-get install xmonad`.

2. Link the config: `mkdir ~/.xmonad && ln -s MONAD/xmonad.hs
~/.xmonad`

### GNOME and XMonad

XMonad can be used to replace the default window manager in GNOME
(metacity). The steps are different depending on the Ubuntu
distribution. Check the subfolders for instructions.

## Troubleshooting

If _xmonad_ won't start, try removing the `file
~/.xmonad/xmonad-x86_64-linux`, which will be recreated.

### Getting the information of a window

Use the `xprop` tool to find the class name, window name or other
properties.
