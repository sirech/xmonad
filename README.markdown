# XMonad Configuration

This is intended as a configuration for _XMonad_ for a development
machine. It is intended to support Eclipse, Emacs and a Terminal
running tmux, as well as mail. Some keys are remapped to use the
windows key when possible.

## XMonad

[XMonad](http://xmonad.org) is a window tiling manager. This means
that windows are automatically resized and moved for you.

## GNOME and XMonad

XMonad can be used to replace the default window manager in GNOME
(metacity). The following steps are needed, assuming the path to this repository is MONAD:

This process
1. Grab _xmonad_: `sudo apt-get install xmonad`.

2. Link the start config: `sudo ln -s MONAD/xmonad.desktop /usr/share/applications`

3. Link the config: `mkdir ~/.xmonad && ln -s MONAD/xmonad.hs ~/.xmonad`

4. Tell GNOME to use _xmonad_: `gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string`

(This can be undone by using the same command, but replacing _xmonad_ with _metacity_)
