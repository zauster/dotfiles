--[[
     Starbreaker Awesome WM config 0.1
     github.com/demifiend

     Based on...

     Multicolor Awesome WM config 2.0 
     github.com/copycat-killer                              
--]]

local awful = require("awful")


theme                               = {}

theme.confdir                       = awful.util.getdir("config") .. "/themes/starbreaker"
-- theme.wallpaper = "/home/reitero/Dotfiles/wallpapers/transparent-polygonal-sphere.jpg"
theme.wallpaper = "/home/reitero/Dotfiles/wallpapers/solarized_ball.png"
-- theme.wallpaper                     = theme.confdir .. "/wall.jpg"

theme.font      = "inconsolata 10" -- sans 8
theme.menu_bg_normal                = "#073642"
theme.menu_bg_focus                 = "#002b36"
theme.bg_normal                     = "#073642"
theme.bg_focus                      = "#002b36"
theme.bg_urgent                     = "#586e75"
theme.fg_normal                     = "#eee8d5"
theme.fg_focus                      = "#fdf6e3"
theme.fg_urgent                     = "#93a1a1"
theme.fg_minimize                   = "#839496"
theme.fg_black                      = "#002b36"
theme.fg_red                        = "#dc322f"
theme.fg_green                      = "#859900"
theme.fg_yellow                     = "#b58900"
theme.fg_blue                       = "#268bd2"
theme.fg_magenta                    = "#d33682"
theme.fg_cyan                       = "#2aa198"
theme.fg_white                      = theme.fg_focus
theme.fg_blu                        = theme.fg_blue
theme.border_width                  = "2"
theme.border_normal                 = theme.bg_focus
theme.border_focus                  = theme.bg_urgent
theme.border_marked                 = theme.fg_red


-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_fg_normal = theme.colors.base03
-- theme.menu_bg_normal = theme.colors.base3
-- theme.menu_submenu_icon = "/home/mony/.config/awesome/themes/arch/submenu.png"
theme.menu_fg_normal                = theme.fg_normal
theme.menu_fg_focus                 = theme.fg_focus
theme.menu_height = 17
theme.menu_width  = 120
theme.menu_border_width = 1
theme.menu_border_color = theme.bg_urgent
theme.submenu_icon                  = theme.confdir .. "/icons/submenu.png"

theme.taglist_squares_sel           = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_b.png"

-- theme.tasklist_disable_icon         = false
theme.tasklist_bg_focus             = theme.bg_urgent
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- theme.tooltip_bg_color = theme.colors.base1
-- theme.tooltip_fg_color = theme.colors.base03
theme.tooltip_border_width = 1
theme.tooltip_border_color = theme.bg_urgent

theme.layout_tile                   = theme.confdir .. "/icons/tile-greyish.png"
theme.layout_tilegaps               = theme.confdir .. "/icons/tilegaps-greyish.png"
theme.layout_tileleft               = theme.confdir .. "/icons/tileleft-greyish.png"
theme.layout_tilebottom             = theme.confdir .. "/icons/tilebottom-greyish.png"
theme.layout_tiletop                = theme.confdir .. "/icons/tiletop-greyish.png"
theme.layout_fairv                  = theme.confdir .. "/icons/fairv-greyish.png"
theme.layout_fairh                  = theme.confdir .. "/icons/fairh-greyish.png"
theme.layout_spiral                 = theme.confdir .. "/icons/spiral-greyish.png"
theme.layout_dwindle                = theme.confdir .. "/icons/dwindle-greyish.png"
theme.layout_max                    = theme.confdir .. "/icons/max-greyish.png"
theme.layout_fullscreen             = theme.confdir .. "/icons/fullscreen-greyish.png"
theme.layout_magnifier              = theme.confdir .. "/icons/magnifier-greyish.png"
theme.layout_floating               = theme.confdir .. "/icons/floating-greyish.png"


return theme
