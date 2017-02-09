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
theme.icondir = theme.confdir .. "/icons/"

-- theme.wallpaper = "/home/reitero/Dotfiles/wallpapers/transparent-polygonal-sphere.jpg"
theme.wallpaper = "/home/reitero/Dotfiles/wallpapers/solarized_ball.png"

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
theme.submenu_icon                  = theme.icondir .. "/submenu.png"

theme.taglist_squares_sel           = theme.icondir .. "/square_a.png"
theme.taglist_squares_unsel         = theme.icondir .. "/square_b.png"

-- theme.tasklist_disable_icon         = false
theme.tasklist_bg_focus             = theme.bg_urgent
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- theme.tooltip_bg_color = theme.colors.base1
-- theme.tooltip_fg_color = theme.colors.base03
theme.tooltip_border_width = 1
theme.tooltip_border_color = theme.bg_urgent

theme.layout_tile                   = theme.icondir .. "/tile-greyish.png"
theme.layout_tilegaps               = theme.icondir .. "/tilegaps-greyish.png"
theme.layout_tileleft               = theme.icondir .. "/tileleft-greyish.png"
theme.layout_tilebottom             = theme.icondir .. "/tilebottom-greyish.png"
theme.layout_tiletop                = theme.icondir .. "/tiletop-greyish.png"
theme.layout_fairv                  = theme.icondir .. "/fairv-greyish.png"
theme.layout_fairh                  = theme.icondir .. "/fairh-greyish.png"
theme.layout_spiral                 = theme.icondir .. "/spiral-greyish.png"
theme.layout_dwindle                = theme.icondir .. "/dwindle-greyish.png"
theme.layout_max                    = theme.icondir .. "/max-greyish.png"
theme.layout_fullscreen             = theme.icondir .. "/fullscreen-greyish.png"
theme.layout_magnifier              = theme.icondir .. "/magnifier-greyish.png"
theme.layout_floating               = theme.icondir .. "/floating-greyish.png"


theme.widget_disk           = theme.icondir .. "/disk.png"
theme.widget_cpu            = theme.icondir .. "/cpu.png"
theme.widget_ac             = theme.icondir .. "/ac.png"
theme.widget_acblink        = theme.icondir .. "/acblink.png"
theme.widget_blank          = theme.icondir .. "/blank.png"
theme.widget_batfull        = theme.icondir .. "/batfull.png"
theme.widget_batmed         = theme.icondir .. "/batmed.png"
theme.widget_batlow         = theme.icondir .. "/batlow.png"
theme.widget_batempty       = theme.icondir .. "/batempty.png"
theme.widget_vol            = theme.icondir .. "/vol.png"
theme.widget_mute           = theme.icondir .. "/mute.png"
theme.widget_pac            = theme.icondir .. "/pac.png"
theme.widget_pacnew         = theme.icondir .. "/pacnew.png"
theme.widget_mail           = theme.icondir .. "/mail.png"
theme.widget_mailnew        = theme.icondir .. "/mailnew.png"
theme.widget_temp           = theme.icondir .. "/temp.png"
theme.widget_tempwarn       = theme.icondir .. "/tempwarm.png"
theme.widget_temphot        = theme.icondir .. "/temphot.png"
theme.widget_wifi           = theme.icondir .. "/wifi.png"
theme.widget_nowifi         = theme.icondir .. "/nowifi.png"
theme.widget_mpd            = theme.icondir .. "/mpd.png"
theme.widget_play           = theme.icondir .. "/play.png"
theme.widget_pause          = theme.icondir .. "/pause.png"
theme.widget_ram            = theme.icondir .. "/ram.png"
theme.widget_mem            = theme.icondir .. "/mem.png"
theme.widget_swap           = theme.icondir .. "/swap.png"
theme.widget_fs             = theme.icondir .. "/fs_01.png"
theme.widget_fs2            = theme.icondir .. "/fs_02.png"
theme.widget_up             = theme.icondir .. "/up.png"
theme.widget_down           = theme.icondir .. "/down.png"

return theme
