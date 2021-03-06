import XMonad
import XMonad.Actions.CycleWS
import XMonad.Config.Gnome
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

import XMonad.Layout.IM
import Data.Ratio ((%))
import XMonad.Layout.Grid
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Actions.CopyWindow

import XMonad.Actions.PhysicalScreens

-- defaults on which we build
-- use e.g. defaultConfig or gnomeConfig
baseConf = gnomeConfig

-- WORKSPACES

ws_eclipse = "7:eclipse"
ws_im = "6:pidgin"

myWorkspaces = ["1:emacs","2:terminal","3:chrome","4:firefox","5:mail",ws_im,ws_eclipse,"8:eclipse-2","9:gitk","0:misc","-","="]
isFullscreen = (== "fullscreen")

-- myManageHook :: ManageHook
myManageHook = composeAll
                 -- Don't tile GNOME Do
               [ resource  =? "Do"   --> doIgnore
               , className =? "Emacs" --> doShift "1:emacs"
               , className  =? "Gnome-terminal" --> doShift "2:terminal"
               , className =? "Eclipse" --> doShift ws_eclipse
               , (className =? "Firefox" <||> className =? "chromium-browser") --> doShift "4:firefox"
               , className =? "google-chrome" --> doShift "3:chrome"
               , className =? "Thunderbird" --> doShift "5:mail"
               , (className =? "Pidgin" <||> className =? "hipchat") --> doShift ws_im
               , className =? "Gitk" --> doShift "9:gitk"
               , className =? "Xmessage"  --> doFloat
               ]


-- LAYOUTS
tallLayout = Tall nmaster delta ratio where
    nmaster = 1
    delta   = 3/100
    ratio   = 1/2
-- tallLayout = named "tall" $ basicLayout
-- wideLayout = named "wide" $ Mirror basicLayout
-- singleLayout = named "single" $ avoidStruts $ noBorders Full
pidginLayout = withIM ratio roster chatLayout where
    chatLayout      = Grid ||| simpleTabbed
    ratio           = (1 % 6)
    roster          = (Role "buddy_list")
myLayoutHook =  avoidStruts $ eclipse $ pidgin $ normal
  where
    normal = tallLayout ||| Mirror tallLayout ||| Full
    eclipse = onWorkspace ws_eclipse Full
    pidgin = onWorkspace ws_im pidginLayout


-- KEYBINDINGS

alt key = "M1-" ++ key
win key = "M-" ++ key

myKeys =
  [ (win "<Space>", spawn "gnome-do")
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

  , (win "w", viewScreen 0)
  , (win "e", viewScreen 1)
  ]
  -- ++
  -- [ (alt k, windows (W.view space))
  -- | space <- myWorkspaces, let k = [head space]]


main :: IO ()
main = xmonad $ baseConf
                           { terminal    = "gnome-terminal"
                           , manageHook = manageHook baseConf <+> myManageHook
                           , modMask     = mod4Mask
                           , focusFollowsMouse = False
                           , workspaces = myWorkspaces
                           , layoutHook = myLayoutHook
                           }
                           `additionalKeysP` myKeys
