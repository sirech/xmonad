import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Gnome
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

-- defaults on which we build
-- use e.g. defaultConfig or gnomeConfig
baseConf = gnomeConfig


-- DISPLAY
-- replace the bright red border with a more stylish colour
myBorderWidth = 2
myNormalBorderColor = "#202030"
myFocusedBorderColor = "#A0A0D0"


-- WORKSPACES

myWorkspaces = ["1:emacs","2:terminal","3:eclipse","4:eclipse-2","5:firefox","6:chrome","7:mail","8:pidgin","9:gitk","0","-","="]
isFullscreen = (== "fullscreen")

myManageHook :: ManageHook
myManageHook = composeAll
                 -- Don't tile GNOME Do
               [ resource  =? "Do"   --> doIgnore
               , className =? "Emacs" --> doShift "1:emacs"
               , resource  =? "gnome-terminal" --> doShift "2:terminal"
               , className =? "Firefox" --> doShift "5:firefox"
               , className =? "Google-chrome" --> doShift "6:chrome"
               , className =? "Thunderbird" --> doShift "7:mail"
               , className =? "Pidgin" --> doShift "8:pidgin"
               , className =? "Gitk" --> doShift "9:gitk"
               ]


-- KEYBINDINGS

alt key = "M1-" ++ key
win key = "M-" ++ key

myKeys =
  [ (win "<Space>", spawn "gnome-do")
  , (win "l", spawn "xflock4")
  , (win "`", sendMessage NextLayout)
    -- , ("M-S-`", setLayout $ XMonad.layoutHook baseConf)

    -- use classic ALT+TAB
  , (alt "<Tab>", windows W.focusDown)
  , (alt "S-<Tab>", windows W.focusUp)

    -- moving workspaces
  , ("C-S-<Left>", prevWS)
  , ("C-S-<Right>", nextWS)
  , (win "S-<Left>", shiftToPrev)
  , (win "S-<Right>", shiftToNext)
  ]
  ++
  [ (alt k, windows (W.view space))
  | space <- myWorkspaces, let k = [head space]]


main :: IO ()
main = xmonad $ baseConf
                           { terminal    = "gnome-terminal"
                           , manageHook = manageHook baseConf <+> myManageHook
                           , modMask     = mod4Mask
                           , focusFollowsMouse = False
                           , workspaces = myWorkspaces
                           , borderWidth = myBorderWidth
                           , normalBorderColor = myNormalBorderColor
                           , focusedBorderColor = myFocusedBorderColor
                           }
                           `additionalKeysP` myKeys
