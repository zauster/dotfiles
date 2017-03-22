--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- Adapted theme - inspired by the Adapta GTK theme                 ---
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

theme      = {}

-- Theme settings {{{
-- theme.icondir              = 
theme.wallpaper            = "/home/reitero/Dotfiles/wallpapers/solarized_ball.png"
theme.border_width         = "3"
-- theme.border_normal        = "3"
-- theme.border_focused       = "3"
-- theme.border_marked        = "3"
theme.menu_height          = "20"
theme.menu_width           = "144"
theme.useless_gap          = "3"
theme.tooltip_border_width = "2"
theme.tooltip_align        = "bottom"
theme.defPath              = "/usr/share/awesome/themes/default/"
theme.layoutPath           = theme.defPath .. "layouts/"
theme.titlebarPath         = theme.defPath .. "titlebar/"
--}}}

-- Theme fonts {{{
        -- theme.font      = "inconsolata 10" -- sans 8
theme.font                 = "Fira Mono SemiBold 10"
theme.taglist_font         = "Fira Mono SemiBold 10"
--"Operator Mono Bold 11"
theme.mono_font            = "Fira Mono SemiBold 10"
-- "Operator Mono Bold 9"
theme.icon_font            = "FontAwesome 9"
-- "Webhostinghub-Glyphs 9"
--}}}

-- Theme colours {{{
theme.black1               = '#363636'
theme.black2               = '#121212'
theme.grey1                = '#696969'
theme.grey2                = '#4f4f4f'
theme.red1                 = '#e05a72'
theme.red2                 = '#9c4252'
theme.green1               = '#59b387'
theme.green2               = '#387054'
theme.green3               = '#3e515a'
theme.green4               = '#2a373e'
theme.yellow1              = '#ffffaf'
theme.yellow2              = '#cccc8c'
theme.orange1              = '#e6a15c'
theme.orange2              = '#805f3f'
theme.blue1                = '#5f87af'
theme.blue2                = '#527496'
theme.blue3                = '#335980'
theme.magenta1             = '#aa7fff'
theme.magenta2             = '#7759B3'
theme.cyan1                = '#559d9d' -- '#5fafaf'
theme.cyan2                = '#5f8787'
theme.white1               = '#f4f4f4' -- '#f9f9f9' -- '#ffffff'
theme.white2               = '#cccccc'
theme.white3               = '#808080'

theme.foreground           = '#eceff1'
-- theme.background           = '#09212d' -- "#213742" -- a lighter tint
theme.background           = '#213742' -- a lighter tint
theme.cursor               = '#1c222e'

theme.fg_normal            = theme.foreground
theme.bg_normal            = theme.green3
theme.fg_focus             = theme.cyan1
theme.bg_focus             = theme.white1
theme.fg_em                = theme.grey1
theme.bg_em                = theme.grey2
theme.fg_urgent            = theme.white1
theme.bg_urgent            = theme.red1
theme.border_normal        = theme.cyan2 --green3
theme.border_focus         = theme.white2
theme.border_marked        = theme.magenta1 --cyan1 --green1
theme.taglist_fg_empty     = theme.cyan2
theme.taglist_bg_empty     = theme.green3
theme.taglist_fg_focus     = theme.green2
theme.taglist_bg_focus     = theme.white1
theme.taglist_fg_occupied  = theme.white2
theme.taglist_bg_occupied  = theme.green3
theme.taglist_fg_urgent    = theme.white1
theme.taglist_bg_urgent    = theme.red1
theme.gradient_1           = theme.red1
theme.gradient_2           = theme.blue3
theme.gradient_3           = theme.blue2
theme.tooltip_border_color = theme.grey2
--}}}

-- Theme icons {{{
theme.tasklist_disable_icon = false

theme.awesome_icon          = "/usr/share/awesome/icons/awesome16.png"
theme.menu_submenu_icon     = theme.defPath .. "submenu.png"

theme.layout_fairh          = theme.layoutPath .. "fairhw.png"
theme.layout_fairv          = theme.layoutPath .. "fairvw.png"
theme.layout_floating       = theme.layoutPath .. "floatingw.png"
theme.layout_magnifier      = theme.layoutPath .. "magnifierw.png"
theme.layout_max            = theme.layoutPath .. "maxw.png"
theme.layout_fullscreen     = theme.layoutPath .. "fullscreenw.png"
theme.layout_tilebottom     = theme.layoutPath .. "tilebottomw.png"
theme.layout_tileleft       = theme.layoutPath .. "tileleftw.png"
theme.layout_tile           = theme.layoutPath .. "tilew.png"
theme.layout_tiletop        = theme.layoutPath .. "tiletopw.png"
theme.layout_spiral         = theme.layoutPath .. "spiralw.png"
theme.layout_dwindle        = theme.layoutPath .. "dwindlew.png"
theme.layout_cornernw       = theme.layoutPath .. "cornernww.png"
theme.layout_cornerne       = theme.layoutPath .. "cornernew.png"
theme.layout_cornersw       = theme.layoutPath .. "cornersww.png"
theme.layout_cornerse       = theme.layoutPath .. "cornersew.png"

theme.titlebar_close_button_normal              = theme.titlebarPath .. "close_normal.png"
theme.titlebar_close_button_focus               = theme.titlebarPath .. "close_focus.png"
theme.titlebar_minimize_button_normal           = theme.titlebarPath .. "minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.titlebarPath .. "minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.titlebarPath .. "ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.titlebarPath .. "ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.titlebarPath .. "ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.titlebarPath .. "ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.titlebarPath .. "sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.titlebarPath .. "sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.titlebarPath .. "sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.titlebarPath .. "sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.titlebarPath .. "floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.titlebarPath .. "floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.titlebarPath .. "floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.titlebarPath .. "floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.titlebarPath .. "maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.titlebarPath .. "maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.titlebarPath .. "maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.titlebarPath .. "maximized_focus_active.png"

--}}}

return theme
