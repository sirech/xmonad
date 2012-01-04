# Making XMonad the default window manager in Ubuntu Natty Narwhal (11.04)
  
1. Link the start config: `sudo ln -s MONAD/narwhal/xmonad.desktop
/usr/share/applications`

2. Tell GNOME to use _xmonad_: `gconftool-2 -s /desktop/gnome/session/required_components/windowmanager xmonad --type string`

(This can be undone by using the same command, but replacing _xmonad_ with _metacity_)
  
