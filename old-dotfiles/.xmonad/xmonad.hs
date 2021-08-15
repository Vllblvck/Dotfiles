------------------------------------------------------------------------
-- Imports 
------------------------------------------------------------------------

import XMonad hiding ( (|||) )

import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.NamedScratchpad

import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.MultiColumns
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.XMonad

import XMonad.Actions.WithAll

import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M 
import Control.Arrow (first)

------------------------------------------------------------------------
-- Settings
------------------------------------------------------------------------

myNormalBorderColor  = "#232627"
myFocusedBorderColor = "#1abc9c"
currentWorkspaceColor = "#1abc9c"
hiddenWorkspaceColor = "#63686d"
visibleWorkspaceColor = "#fcfcfc"
urgentWorkspaceColor = "#ed1515"
layoutNameColor = "#1abc9c"
stdinSeparatorColor = "#11d116"

myModKey = mod4Mask
myBorderWidth = 2
myTerminal = "alacritty"
myMainBrowser = "brave"
mySecondaryBrowser = "qutebrowser"

------------------------------------------------------------------------
-- Startup
------------------------------------------------------------------------

myStartupHook = do
    setWMName "LG3D" -- This exists so java apps display properly
    spawnOnce "picom &"
    spawnOnce "dunst &"
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &"
    spawnOnce "betterlockscreen -u /usr/share/backgrounds/mountains_purple.jpg &"
    spawnOnce "stalonetray --icon-size=20 --kludges=force_icons_size &"
    spawnOnce ("udiskie -s -N -f \"" ++ myTerminal ++ " -e ranger\" &")
    spawnOnce "qbittorrent &"

------------------------------------------------------------------------
-- Key bindings
------------------------------------------------------------------------

myKeys = 

    -- Xmonad
    [ ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
    , ("M-d", shellPrompt shellXPConfig)
    , ("M-x", xmonadPromptC customPromptActions shellXPConfig)
    , ("M-p n", AL.launchApp shellXPConfig (myTerminal ++ " -e nvim"))
    , ("M-p w", AL.launchApp shellXPConfig myMainBrowser)

    -- Windows
    , ("M-S-q", kill)
    , ("M-S-a", killAll)
    , ("M-h", sendMessage Shrink)
    , ("M-S-h", sendMessage MirrorShrink)
    , ("M-l", sendMessage Expand)
    , ("M-S-l", sendMessage MirrorExpand)
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)
    , ("M-m", windows W.focusMaster)
    , ("M-S-j", windows W.swapDown)
    , ("M-S-k", windows W.swapUp)
    , ("M-S-m", windows W.swapMaster)
    , ("M-t", withFocused $ windows . W.sink)
    , ("M-,", sendMessage (IncMasterN (1)))
    , ("M-.", sendMessage (IncMasterN (-1)))

    -- Layouts 
    , ("M-<Tab>", sendMessage NextLayout)
    , ("M-S-<Tab>", sendMessage $ JumpToLayout "ResizableTall")
    , ("M-f", sendMessage (Toggle FULL) >> sendMessage ToggleStruts)
    , ("M-v", sendMessage $ Toggle MIRROR)
    , ("M-s", refresh)

    -- Scratchpads
    , ("M-u", namedScratchpadAction myScratchpads "mocp")
    , ("M-S-<Return>", namedScratchpadAction myScratchpads "terminal")
    , ("M-c", namedScratchpadAction myScratchpads "calendar")

    -- Volume
    , ("M-=", spawn "/home/vllblvck/Scripts/pulse-volume.sh increase")
    , ("M--", spawn "/home/vllblvck/Scripts/pulse-volume.sh decrease")
    , ("M-0", spawn "/home/vllblvck/Scripts/pulse-volume.sh mute")

    -- Launching apps
    , ("M-<Return>", spawn myTerminal)
    , ("M-w", spawn myMainBrowser)
    , ("M-S-w", spawn mySecondaryBrowser)
    , ("M-y", spawn (myTerminal ++ " -e pacmixer"))
    , ("M-r", spawn (myTerminal ++ " -e ranger"))
    , ("M-z", spawn "caprine")
    , ("M-S-s", spawn "flameshot gui") ]

------------------------------------------------------------------------
-- Scratchpads
------------------------------------------------------------------------

myScratchpads = [ NS "mocp" (myTerminal ++ " -t mocp -e mocp") (title =? "mocp") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
                , NS "terminal" (myTerminal ++ " -t terminal") (title =? "terminal") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)) 
                , NS "calendar" (myTerminal ++ " -t calendar -e calcurse") (title =? "calendar") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)) ] 

------------------------------------------------------------------------
-- Layouts
------------------------------------------------------------------------

myLayout =
    smartBorders
    $ avoidStruts
    $ mkToggle (NOBORDERS ?? FULL ?? EOT)
    $ mkToggle (single MIRROR)
    $ renamed [CutWordsLeft 1]
    $ spacingRaw False (Border 10 10 10 10) True (Border 5 5 5 5) True 
    $ (tall ||| Grid ||| mCol ||| spiral (6/7) ||| threeCol)
         where tall = ResizableTall 1 (3/100) (1/2) []
	       mCol = multiCol [1] 1 0.01 (-0.5)
	       threeCol = ThreeCol 1 (3/100) (1/2)

------------------------------------------------------------------------
-- Window rules:
------------------------------------------------------------------------

myManageHook = composeAll
    [ namedScratchpadManageHook myScratchpads
    , className =? "qutebrowser"        --> doShift ( myWorkspaces !! 0 )
    , className =? "LBRY"               --> doShift ( myWorkspaces !! 0 )
    , className =? "firefox"            --> doShift ( myWorkspaces !! 0 )
    , className =? "Brave-browser"      --> doShift ( myWorkspaces !! 0 )
    , title     =? "nvim-dev"           --> doShift ( myWorkspaces !! 2 )
    , className =? "code-oss"           --> doShift ( myWorkspaces !! 2 )
    , className =? "jetbrains-rider"    --> doShift ( myWorkspaces !! 2 )
    , className =? "jetbrains-studio"   --> doShift ( myWorkspaces !! 2 )
    , className =? "Caprine"            --> doShift ( myWorkspaces !! 3 )
    , className =? "discord"            --> doShift ( myWorkspaces !! 3 )
    , className =? "Steam"              --> doShift ( myWorkspaces !! 4 )
    , className =? "Lutris"             --> doShift ( myWorkspaces !! 4 )
    , className =? "Thunderbird"        --> doShift ( myWorkspaces !! 5 )
    , className =? "qBittorrent"        --> doShift ( myWorkspaces !! 6 )
    , className =? "Virt-manager"       --> doShift ( myWorkspaces !! 8 )
    -- for some reason this opton makes virtualbox crash on launhch
    --, className =? "VirtualBox Manager" --> doShift ( myWorkspaces !! 8 )
    , resource  =? "desktop_window"     --> doIgnore
    , fmap not isDialog                 --> insertPosition End Newer ]

------------------------------------------------------------------------
-- Xprompt
------------------------------------------------------------------------

shellXPConfig :: XPConfig
shellXPConfig = def
      { font                = "xft:Mononoki Nerd Font:size=12"
      , bgColor             = "#232627"
      , fgColor             = "#fcfcfc"
      , bgHLight            = "#1abc9c"
      , fgHLight            = "#232627"
      , promptBorderWidth   = 0
      , position            = Top
      , height              = 20
      , showCompletionOnTab = False
      , alwaysHighlight     = True
      , maxComplRows        = Just 2 
      }

customPromptActions :: [(String, X())]
customPromptActions = 
    [ ("shutdown", spawn "systemctl poweroff")
    , ("reboot", spawn "systemctl reboot")
    , ("lock", spawn "betterlockscreen -l")
    , ("close", io (exitWith ExitSuccess)) ]

--customPromptKeymap :: M.Map (KeyMask, KeySym) (XP ())
--customPromptKeymap = M.fromList $
    --map (first $ (,) mod1Mask)
    --[ (xK_f, moveCursor Next)
    --, (xK_b, moveCursor Prev) ]

------------------------------------------------------------------------
-- Workspaces
------------------------------------------------------------------------

xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]
        
myWorkspaces = clickable . (map xmobarEscape) 
               $ ["WEB","TERM","DEV","CHAT","MISC","MAIL","TRNT","VIRT"]
  where
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..8] l,
                      let n = i ] 

------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------

main = do
    xmproc <- spawnPipe "xmobar /home/vllblvck/.config/xmobar/xmobarrc"
    xmonad $ withUrgencyHook NoUrgencyHook $ docks def 
        {
        terminal           = myTerminal,
        modMask            = myModKey,
        workspaces         = myWorkspaces,
        borderWidth        = myBorderWidth,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayout,
        startupHook        = myStartupHook,
        manageHook         = myManageHook,
        logHook            = dynamicLogWithPP $ def
		  		 { ppOutput = hPutStrLn xmproc
		  		 , ppCurrent = xmobarColor currentWorkspaceColor "" . wrap "[" "]"
		  		 , ppVisible = xmobarColor visibleWorkspaceColor ""
				 , ppHidden = xmobarColor hiddenWorkspaceColor ""
				 , ppHiddenNoWindows = xmobarColor visibleWorkspaceColor ""
				 , ppLayout = xmobarColor layoutNameColor ""
				 , ppSep = "<fc=" ++ stdinSeparatorColor ++ "> || </fc>"
                                 , ppUrgent = xmobarColor urgentWorkspaceColor "" .wrap "!" "!"
				 , ppOrder = \(ws:l:_:_) -> [ws,l]
		  		 },
        handleEventHook    = mempty,
        focusFollowsMouse  = True,
        clickJustFocuses   = False
	} `additionalKeysP` myKeys
