{-# LANGUAGE FlexibleContexts #-}
--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad

import Control.Monad (liftM, sequence)
import Data.List     (intercalate)
import Data.Monoid
import System.Exit

import qualified Data.Map                          as M
import qualified XMonad.Actions.FlexibleManipulate as Flex
import qualified XMonad.StackSet                   as W
-- import qualified XMonad.Actions.FlexibleResize as Flex

import XMonad.Actions.Minimize
-- import XMonad.Actions.UpdateFocus
import XMonad.Actions.UpdatePointer

import XMonad.Layout.Minimize
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
-- import XMonad.Layout.LayoutModifier

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place

import XMonad.Util.Loggers
import XMonad.Util.NamedWindows (getName, unName)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run

-- import System.IO.UTF8
-- import Codec.Binary.UTF8.String

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "xterm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
-- myWorkspaces    = ["web", "code", "files", "docs", "media"]

-- Border colors for unfocused and focused windows, respectively.
--
-- myNormalBorderColor  = "#3d3d3d"
-- myFocusedBorderColor = "#aed4d5"
myNormalBorderColor  = "#3a3a3a"
myFocusedBorderColor = "#85add4"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn dmenuCommand)

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Center window
    , ((modm .|. shiftMask, xK_t     ), placeFocused $ centerPlacement)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Show the generic scrachpad
    , ((modm              , xK_o     ), namedScratchpadAction myScratchpads "scratchpad")

    -- Screenshots
    , ((0                 , xK_Print  ), spawn $ "scrot -d 1" ++ notifyScreenshot)

    , ((0 .|. shiftMask   , xK_Print  ), spawn $ "sleep 0.3; scrot -s" ++ notifyScreenshot)

    , ((modm              , xK_Print  ), spawn $ "scrot -u" ++ notifyScreenshot)

    -- Select window by title in rofi
    , ((modm .|. shiftMask, xK_g      ), spawn "rofi -show window")

    -- XF86AudioMute
    , ((0                 , 0x1008ff12), spawn "pamixer --toggle-mute")

    -- XF86AudioLowerVolume
    , ((0                 , 0x1008ff11), spawn "pamixer --decrease 5")

    -- XF86AudioRaiseVolume
    , ((0                 , 0x1008ff13), spawn "pamixer --increase 5")

    -- XF86MonBrightnessDown
    , ((0                 , 0x1008ff03), spawn "light -U 10")

    -- XF86MonBrightnessUp
    , ((0                 , 0x1008ff02), spawn "light -A 10")

    -- Minimize and unminimize windows
    , ((modm,               xK_m     ), withFocused minimizeWindow)
    , ((modm .|. shiftMask, xK_m     ), withLastMinimized maximizeWindowAndFocus)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    where dmenuCommand = "rofi -show drun"
          notifyScreenshot = "; notify-send --app-name=scrot \"Saved Screenshot\""
          centerPlacement = withGaps (16,0,16,0) (smart (0.5,0.5))
    -- dmenuCommand = "dmenu_run"
    --                ++ " -fn 'Fira Mono:pixelsize=12.1':style=Medium"
    --                ++ " -nb '#282828' -nf '#ebdbb2'"
    --                ++ " -sb '#d79921' -sf '#282828'"

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    -- , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
    --                                    >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> Flex.mouseWindow Flex.resize w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

myLayout = minimize $ smartBorders $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--

center w h = W.RationalRect ((1 - w) / 2) ((1 - h) / 2) w h

myScratchpads = [ NS "scratchpad"
                     "xterm -class scratchpad"
                     (className =? "scratchpad")
                     (customFloating $ center 0.7 0.7)
                ]

myManageHook = composeAll $
        [ className =? "MPlayer"        --> doFloat
        , className =? "Gimp"           --> doFloat
        , className =? "feh"            --> doCenterFloat
        , isFullscreen                  --> doFullFloat
        , isDialog                      --> doCenterFloat ]
        ++
        [ namedScratchpadManageHook myScratchpads
        , placeHook simpleSmart ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
logTitles ppFocus =
        let windowTitles windowset = sequence (map (fmap showName . getName) (W.index windowset))
                where fw = W.peek windowset
                      showName nw =
                          let window = unName nw
                              name   = shorten 35 $ show nw
                          in if maybe False (== window) fw
                               then ppFocus name
                               else name
        in withWindowSet $ liftM (Just . (intercalate " : ")) . windowTitles

myXmobar conf = do
    h <- spawnPipe "xmobar ~/.xmobar/xmobarrc"
    return $ docks $ conf
        { layoutHook = avoidStruts (layoutHook conf)
            , logHook = do
                logHook conf
                dynamicLogWithPP $ def
                    { ppOutput  = hPutStrLn h
                    , ppCurrent = xmobarColor "#add4fb" "" . wrap "[" "]" . wrap "<fn=1>" "</fn>"
                    -- Remove "Minimize" from the layout name.
                    , ppLayout  = (\x -> case x of
                                         "Minimize Tall"        -> "Tall"
                                         "Minimize Mirror Tall" -> "Mirror Tall"
                                         "Minimize Full"        -> "Full"
                                         _                      -> x
                                  )
                    -- Filter out NSP workspace from the output.
                    , ppHidden  = (\x -> case x of
                                         "NSP" -> ""
                                         _     -> x
                                  )
                    , ppOrder  = \(ws:l:_:e) -> [ws, l] ++ e
                    , ppExtras = [ logTitles $ xmobarColor "#87af87" "" . wrap "<fn=1>" "</fn>" ]
                    -- , ppHiddenNoWindows = xmobarColor "#9c9c9c" ""
                    }
        }

myLogHook = updatePointer (0.5, 0.5) (0, 0)

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad =<< myXmobar defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = ewmh $ def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
