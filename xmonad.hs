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

myWorkspaces = ["1:dev","2:web","3:mail","4:comm","5:ham","6:tmp","7:dvi","8","9","0","-","="]
isFullscreen = (== "fullscreen")

-- Don't tile GNOME Do
myManageHook :: [ManageHook]
myManageHook = 
    [ resource  =? "Do"   --> doIgnore ]
    
    
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
                           , manageHook = manageHook baseConf <+> composeAll myManageHook
                           , modMask     = mod4Mask
                           , focusFollowsMouse = False
                           , workspaces = myWorkspaces
                           , borderWidth = myBorderWidth
                           , normalBorderColor = myNormalBorderColor
                           , focusedBorderColor = myFocusedBorderColor
                           } 
                           `additionalKeysP` myKeys
