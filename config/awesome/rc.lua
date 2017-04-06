
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local lain = require("lain")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
                    title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
                             -- Make sure we don't go into an endless error loop
                             if in_error then return end
                             in_error = true

                             naughty.notify({ preset = naughty.config.presets.critical,
                                              title = "Oops, an error happened!",
                                              text = tostring(err) })
                             in_error = false
   end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
beautiful.init(awful.util.getdir("config") .."/themes/adapted/theme.lua")


-- This is used later as the default terminal and editor to run.
terminal = "urxvt -name DURxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.floating,
   -- awful.layout.suit.tile,
   -- awful.layout.suit.tile.left,
   -- awful.layout.suit.tile.bottom,
   -- awful.layout.suit.tile.top,
   awful.layout.suit.fair,
   awful.layout.suit.fair.horizontal,
   -- awful.layout.suit.spiral,
   -- awful.layout.suit.spiral.dwindle,
   awful.layout.suit.max,
   -- awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.magnifier,
   -- awful.layout.suit.corner.nw,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
   local instance = nil

   return function ()
      if instance and instance.wibox.visible then
         instance:hide()
         instance = nil
      else
         instance = awful.menu.clients({ theme = { width = 250 } })
      end
   end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end},
   { "system reboot", "reboot" },
   { "system shutdown", "poweroff" }
}

internetmenu = {   
   { "firefox", "firefox" },
   { "chromium", "chromium"},
   { "thunderbird", "thunderbird" },
   { "transmission", "transmission-gtk" },
   { "skype", "skype" }
}

mediamenu = {
   { "sonata", "sonata" },
   -- { "vlc", "vlc" },
   -- { "asunder", "asunder"},
   { "mplayer", "gnome-mplayer"}
}

manamenu = {
   { "file manager", "pcmanfm" },
   { "keepassx", "keepassx"},
   { "archiver", "xarchiver" }
}

graphicsmenu = {
   { "gimp", "gimp" },
   { "image viewer", "gpicview" }
}

editormenu = {
   { "emacs", "emacsen" },
   { "emacsserver", "emacs --daemon" } --,
   -- { "emacsclient", "emacsclient -c" }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu,
                                      beautiful.awesome_icon },
                             { "internet", internetmenu },
                             { "media", mediamenu },
                             { "utils", manamenu },
                             { "editor", editormenu },
                             { "open terminal", terminal }
}
                       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

space = wibox.widget.textbox('  ')
spr = wibox.widget.textbox('<span color="'..beautiful.border_focus..'" weight="bold"> ┃</span>')
sprb = wibox.widget.textbox('<span color="'..beautiful.border_focus..'" weight="bold"> ┃ </span>')


-- Create a textclock widget
-- mytextclock = wibox.widget.textclock( '<span font="'..beautiful.font..'" background="'..beautiful.white1..'" color="'..beautiful.background..'"> %a %b %d, %H:%M </span>' )
mytextclock = wibox.widget.textclock()


--
-- Widgets
--

-- Align text to the right {{{
local function pad_to_length(value, ...)
   local max_length = 0
   value = tostring(value)
   for i=1, select('#', ...) do
      local arg = tostring(select(i, ...))
      max_length = math.max(max_length, #arg)
   end
   if max_length > #value then
      value = string.rep(' ', max_length - #value) .. value
   end
   return value
end
-- }}}

-- Power widget {{{
local widget_power = lain.widget.bat({
      timeout = 0.1,
      battery = BAT,
      notify = "on",

      settings = function()
         if bat_now.status == 'N/A' then
            widget:set_markup('<span font="'..beautiful.icon_font..'">  </span> AC')
         elseif bat_now.status == 'Charging' then
            widget:set_markup('<span font="'..beautiful.icon_font..'">  </span> '..bat_now.perc..'%')
         else
            if bat_now.perc <= 10 then
               widget:set_markup('<span font="'..beautiful.icon_font..'">  </span> '..bat_now.perc..'%')
            elseif bat_now.perc <= 35 then
               widget:set_markup('<span font="'..beautiful.icon_font..'">  </span> '..bat_now.perc..'%')
            elseif bat_now.perc <= 70 then
               widget:set_markup('<span font="'..beautiful.icon_font..'">  </span> '..bat_now.perc..'%')
            elseif bat_now.perc <= 85 then
               widget:set_markup('<span font="'..beautiful.icon_font..'">  </span> '..bat_now.perc..'%')
            else
               widget:set_markup('<span font="'..beautiful.icon_font..'">  </span> '..bat_now.perc..'%')
            end
         end

         bat_notification_low_preset = {
            title = "Battery low",
            text = "Plug the cable!",
            timeout = 15,
            fg = beautiful.red1,
            bg = beautiful.black2
         }

         bat_notification_critical_preset = {
            title = "Battery exhausted",
            text = "Shutdown imminent",
            timeout = 15,
            fg = beautiful.white1,
            bg = beautiful.black2
         }

      end
})
-- local tooltip_bat = awful.tooltip({
--   objects = { widget_power },
--   margin_leftright = 6,
--   margin_topbottom = 16,
--   shape = gears.shape.infobubble,
--   timer_function = function()
--     local title = "Power house"
--     local tlen = string.len(title)
--     local text
--     if bat_now.status == 'N/A' then
--       text = ' <span font="'..beautiful.mono_font..'">'..
--              ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title..'</span> \n'..
--              ' <span weight="bold">'..string.rep('-', tlen)..'</span> \n'..
--              ' ▪ status    <span color="'..beautiful.fg_normal..'">\n   Plugged in \n   No battery </span>'
--       text = text..'</span>'
--     else
--       text = ' <span font="'..beautiful.mono_font..'">'..
--              ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title..'</span> \n'..
--              ' <span weight="bold">'..string.rep('-', tlen)..'</span> \n'
--       if bat_now.status == 'Discharging' then
--         text = text..' ▪ status    <span color="'..beautiful.fg_normal..'">discharging </span>\n'
--       elseif bat_now.status == 'Full' then
--         text = text..' ▪ status    <span color="'..beautiful.fg_normal..'">charged </span>\n'
--       else
--         text = text..' ▪ status    <span color="'..beautiful.fg_normal..'">charging </span>\n'
--       end
--       text = text..' ⚡ level     <span color="'..beautiful.fg_normal..'">'..bat_now.perc..'% </span>\n'..
--                   ' ◴ time left <span color="'..beautiful.fg_normal..'">'..bat_now.time..' </span>'
--       text = text..'</span>'
--     end
--     return text
--   end
-- })
-- Power widget }}}

-- CPU
local widget_cpu = lain.widget.cpu({
      settings = function()
         -- widget:set_text(" " .. cpu_now.usage .. "% ")
         widget:set_markup("<span font='" ..beautiful.icon_font.. "'> </span> " .. cpu_now.usage .. " %")
      end
})

-- ALSA volume bar {{{
local icon_alsa = wibox.widget.textbox()
icon_alsa:buttons(awful.util.table.join(
                     awful.button({ }, 1, function () awful.spawn.with_shell(mymixer) end),
                     awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr1) end),
                     awful.button({ altkey }, 1, function () awful.spawn.with_shell(musicplr2) end)))
local volume = lain.widget.alsabar({width = 35, ticks = true, ticks_size = 4, step = "2%",
                                    settings = function()
                                       if volume_now.status == "off" then
                                          icon_alsa:set_markup('<span font="'..beautiful.icon_font..'"></span>')
                                       elseif volume_now.level == 0 then
                                          icon_alsa:set_markup('<span font="'..beautiful.icon_font..'"></span>')
                                       elseif volume_now.level <= 50 then
                                          icon_alsa:set_markup('<span font="'..beautiful.icon_font..'"></span>')
                                       else
                                          icon_alsa:set_markup('<span font="'..beautiful.icon_font..'"></span>')
                                       end
                                    end,
                                    colors =
                                       {
                                          background = beautiful.bg_normal,
                                          mute = beautiful.red1,
                                          -- unmute = function()
                                          --   if volume_now.level <= 10 then
                                          --     unmute = beautiful.red1
                                          --   elseif volume_now.level <= 50 then
                                          --     unmute = beautiful.blue1
                                          --   else
                                          --     unmute = beautiful.green1
                                          --   end
                                          -- end
                                          unmute = beautiful.fg_normal
                                       }
})
local volmargin = wibox.container.margin(volume.bar, 8, 0, 5, 5)
local widget_alsa = wibox.container.background(volmargin)
-- }}}

-- Memory widget {{{2
local widget_mem = lain.widget.mem({
      settings = function()
         widget:set_markup('<span font="' ..beautiful.icon_font .. '"> </span>  '..mem_now.used..' MB')
      end
})

-- local tooltip_mem = awful.tooltip({
--       objects = { widget_mem },
--       margin_leftright = 6,
--       margin_topbottom = 16,
--       shape = gears.shape.infobubble,
--       timer_function = function()
--          local title = "memory &amp; swap usage"
--          local used = pad_to_length(mem_now.used, mem_now.swapused)
--          local swapused = pad_to_length(mem_now.swapused, mem_now.used)
--          local text
--          text = ' <span font="'..beautiful.mono_font..'">'..
--             ' <span weight="bold" color="'..beautiful.fg_normal..'">'..title..'</span> \n'..
--             ' <span weight="bold">-------------------</span> \n'..
--             ' ▪ memory <span color="'..beautiful.fg_normal..'">'..used..'</span> MB \n'..
--             ' ▪ swap   <span color="'..beautiful.fg_normal..'">'..swapused..'</span> MB </span>'
--          return text
--       end
-- })
-- Memory widget }}}

-- Temperature widget {{{
local widget_temp = lain.widget.temp({
      tempfile = "/sys/class/thermal/thermal_zone1/temp",
      settings = function ()
         widget:set_markup('<span font="'..beautiful.icon_font..'"> </span> '..coretemp_now..'°')
      end
})
-- Temperature widget }}}


-- Keyboard map indicator and changer {{{
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "de", "basic" }, { "de", "neo" } }
kbdcfg.current = 2  -- de neo is my default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][2])
kbdcfg.switch = function ()
   kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
   local t = kbdcfg.layout[kbdcfg.current]
   kbdcfg.widget:set_text(" " .. t[2])
   os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

-- Mouse bindings
kbdcfg.widget:buttons(
   awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)




-- }}}

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
         if client.focus then
            client.focus:move_to_tag(t)
         end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
         if client.focus then
            client.focus:toggle_tag(t)
         end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
         if c == client.focus then
            c.minimized = true
         else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
               c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
         end
   end),
   awful.button({ }, 3, client_menu_toggle_fn()),
   awful.button({ }, 4, function ()
         awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
         awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

-- Re-set wallpaper when a screen's geometry changes
-- (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


tags = {
   names = { "  ", "  ", "  ", "  ", "  "},
   layout = { awful.layout.layouts[1], awful.layout.layouts[4],
              awful.layout.layouts[2], awful.layout.layouts[2],
              awful.layout.layouts[2] }
}


awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      set_wallpaper(s)

      -- Each screen has its own tag table.
      -- awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" },
      --    s, awful.layout.layouts[1])
      awful.tag(tags.names, s, tags.layout)

      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt()
      -- Create an imagebox widget which will contains an icon indicating which layout we're using.
      -- We need one layoutbox per screen.
      s.mylayoutbox = awful.widget.layoutbox(s)
      s.mylayoutbox:buttons(awful.util.table.join(
                               awful.button({ }, 1, 
                                  function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, 
                                  function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, 
                                  function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, 
                                  function () awful.layout.inc(-1) end)))
      -- Create a taglist widget
      s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all,
                                         taglist_buttons)

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

      -- Create the wibox
      s.mywibox = awful.wibar({ position = "top", height = 25, screen = s })

      -- Add widgets to the wibox
      s.mywibox:setup {
         layout = wibox.layout.align.horizontal,
         { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
            sprb,
         },
         s.mytasklist, -- Middle widget
         { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            sprb,
            mykeyboardlayout,
            wibox.widget.systray(),

            spr,
            kbdcfg.widget,
            spr,
            widget_alsa,
            spr,
            widget_temp,
            spr,
            widget_cpu,
            spr,
            widget_mem,
            spr,
            widget_power,
            spr,
            -- space,
            mytextclock,
         },
      }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
                awful.button({ }, 3, function () mymainmenu:toggle() end),
                awful.button({ }, 4, awful.tag.viewnext),
                awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   awful.key({ modkey,           }, "h",      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
      {description = "view next", group = "tag"}),
   awful.key({ modkey,           }, "x", awful.tag.history.restore,
      {description = "go back", group = "tag"}),

   awful.key({ modkey,           }, "Tab",
      function ()
         awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   -- awful.key({ modkey,           }, "k",
   --     function ()
   --         awful.client.focus.byidx(-1)
   --     end,
   --     {description = "focus previous by index", group = "client"}
   -- ),
   awful.key({ modkey,           }, "z",
      function ()
       --   currentscreen = awful.screen.focused
       --   if currentscreen == 1 then
            awful.screen.focus(2)
       --   else
       --      awful.screen.focus(1)
       --   end
       end,
       {description = "focus some screen", group = "client"}
   ),
   awful.key({ modkey,           }, "b",
      function ()
         awful.screen.focus(1)
      end,
      {description = "focus some screen", group = "client"}
   ),
   awful.key({ modkey,           }, "v", function () mymainmenu:show() end,
      {description = "show main menu", group = "awesome"}),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j",
      function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index",
       group = "client"}),
   awful.key({ modkey, "Shift"   }, "k",
      function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index",
       group = "client"}),
   awful.key({ modkey, "Control" }, "j",
      function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen",
       group = "screen"}),
   awful.key({ modkey, "Control" }, "k",
      function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen",
       group = "screen"}),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client",
       group = "client"}),
   -- awful.key({ modkey,           }, "Tab",
   --    function ()
   --       awful.client.focus.history.previous()
   --       if client.focus then
   --          client.focus:raise()
   --       end
   --    end,
   --    {description = "go back", group = "client"}),

   -- Standard program
   awful.key({ modkey,           }, "d",
      function () awful.spawn(terminal) end,
      {description = "open a terminal",
       group = "launcher"}),
   awful.key({ modkey, "Control" }, "r", awesome.restart,
      {description = "reload awesome",
       group = "awesome"}),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit,
      {description = "quit awesome", group = "awesome"}),

   awful.key({ modkey,           }, "l",
      function () awful.tag.incmwfact( 0.05)          end,
      {description = "increase master width factor",
       group = "layout"}),
   awful.key({ modkey,           }, "h",
      function () awful.tag.incmwfact(-0.05)          end,
      {description = "decrease master width factor",
       group = "layout"}),
   awful.key({ modkey, "Shift"   }, "h",
      function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients",
       group = "layout"}),
   awful.key({ modkey, "Shift"   }, "l",
      function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients",
       group = "layout"}),
   -- awful.key({ modkey, "Control" }, "h",
   --    function () awful.tag.incncol( 1, nil, true)    end,
   --    {description = "increase the number of columns",
   --     group = "layout"}),
   -- awful.key({ modkey, "Control" }, "l",
   --    function () awful.tag.incncol(-1, nil, true)    end,
   --    {description = "decrease the number of columns",
   --     group = "layout"}),
   awful.key({ modkey,           }, "space",
      function () awful.layout.inc( 1)                end,
      {description = "select next",
       group = "layout"}),
   awful.key({ modkey, "Shift"   }, "space",
      function () awful.layout.inc(-1)                end,
      {description = "select previous",
       group = "layout"}),

   awful.key({ modkey, "Control" }, "n",
      function ()
         local c = awful.client.restore()
         -- Focus restored client
         if c then
            client.focus = c
            c:raise()
         end
      end,
      {description = "restore minimized", group = "client"}),

   -- Prompt
   awful.key({ modkey },            "u",
      function () awful.screen.focused().mypromptbox:run() end,
      {description = "run prompt",
       group = "launcher"}),

   -- awful.key({ modkey }, "x",
   --    function ()
   --       awful.prompt.run {
   --          prompt       = "Run Lua code: ",
   --          textbox      = awful.screen.focused().mypromptbox.widget,
   --          exe_callback = awful.util.eval,
   --          history_path = awful.util.get_cache_dir() .. "/history_eval"
   --       }
   --    end,
   --    {description = "lua execute prompt", group = "awesome"}),
   
   -- Menubar
   awful.key({ modkey }, "p", function() menubar.show() end,
      {description = "show the menubar", group = "launcher"})
   
)

-- Custom keybindings
globalkeys = awful.util.table.join(globalkeys, 
                                   awful.key({ modkey, }, "#94",
                                      function() awful.spawn("pcmanfm") end),
                                   awful.key({ }, "XF86Explorer",
                                      function() awful.spawn("pcmanfm") end),
                                   awful.key({ modkey, }, "i",
                                      function () awful.spawn("chromium") end),
                                   awful.key({ modkey, }, "a",
                                      function () awful.spawn("firefox") end),
                                   awful.key({ modkey, }, "o",
                                      function () awful.spawn("thunderbird") end),
                                   awful.key({ modkey, }, "e",
                                      function () awful.spawn("emacs") end),
                                   awful.key({ modkey, }, "#52",
                                      function () awful.spawn("sonata") end),
                                   awful.key({ }, "XF86MonBrightnessDown",
                                      function () awful.spawn("xbacklight -dec 7") end),
                                   awful.key({ }, "XF86MonBrightnessUp",
                                      function () awful.spawn("xbacklight -inc 7") end),
                                   awful.key({ }, "XF86AudioMute",
                                      function () awful.spawn("amixer set Master toggle") end),
                                   awful.key({ }, "XF86AudioRaiseVolume",
                                      function () awful.spawn("amixer -q sset Master 3%+", false)
                                   end),
                                   awful.key({ }, "XF86AudioLowerVolume",
                                      function () awful.spawn("amixer -q sset Master 3%-", false)
                                   end)
)


clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",
      function (c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      {description = "toggle fullscreen",
       group = "client"}),
   -- awful.key({ modkey,   }, "Escape",
   awful.key({ modkey, "Shift"   }, "Escape",
      function (c) c:kill()                         end,
      {description = "close",
       group = "client"}),
   awful.key({ modkey, "Control" }, "space",
      awful.client.floating.toggle                     ,
      {description = "toggle floating",
       group = "client"}),
   awful.key({ modkey, "Control" }, "Return",
      function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master",
       group = "client"}),
   awful.key({ modkey,           }, "s",
      function (c) c:move_to_screen()               end,
      {description = "move to screen",
       group = "client"}),
   awful.key({ modkey,           }, "t",
      function (c) c.ontop = not c.ontop            end,
      {description = "toggle keep on top",
       group = "client"}),
   -- awful.key({ modkey,           }, "n",
   --    function (c)
   --       -- The client currently has the input focus, so it cannot be
   --       -- minimized, since minimized clients can't have the focus.
   --       c.minimized = true
   --    end ,
   --    {description = "minimize", group = "client"}),
   awful.key({ modkey,           }, "m",
      function (c)
         c.maximized = not c.maximized
         c:raise()
      end,
      {description = "maximize",
       group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = awful.util.table.join(globalkeys,
                                      -- View tag only.
                                      awful.key({ modkey }, "#" .. i + 9,
                                         function ()
                                            local screen = awful.screen.focused()
                                            local tag = screen.tags[i]
                                            if tag then
                                               tag:view_only()
                                            end
                                         end,
                                         {description = "view tag #"..i, group = "tag"}),
                                      -- Toggle tag display.
                                      awful.key({ modkey, "Control" }, "#" .. i + 9,
                                         function ()
                                            local screen = awful.screen.focused()
                                            local tag = screen.tags[i]
                                            if tag then
                                               awful.tag.viewtoggle(tag)
                                            end
                                         end,
                                         {description = "toggle tag #" .. i, group = "tag"}),
                                      -- Move client to tag.
                                      awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                         function ()
                                            if client.focus then
                                               local tag = client.focus.screen.tags[i]
                                               if tag then
                                                  client.focus:move_to_tag(tag)
                                               end
                                            end
                                         end,
                                         {description = "move focused client to tag #"..i, group = "tag"}),
                                      -- Toggle tag on focused client.
                                      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                         function ()
                                            if client.focus then
                                               local tag = client.focus.screen.tags[i]
                                               if tag then
                                                  client.focus:toggle_tag(tag)
                                               end
                                            end
                                         end,
                                         {description = "toggle focused client on tag #" .. i, group = "tag"})
   )
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = clientkeys,
                    buttons = clientbuttons,
                    screen = awful.screen.preferred,
                    placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
   },

   -- Floating clients.
   { rule_any = {
        instance = {
           "DTA",  -- Firefox addon DownThemAll.
           "copyq",  -- Includes session name in class.
        },
        class = {
           "Arandr",
           "gimp",
           "Plugin-container",
           "Download",
           "Gpick",
           "Kruler",
           "MessageWin",  -- kalarm.
           "Sxiv",
           "Wpa_gui",
           "pinentry",
           "veromix",
           "xtightvncviewer"},

        name = {
           "Event Tester",  -- xev.
        },
        role = {
           "AlarmWindow",  -- Thunderbird's calendar.
           "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
   }, properties = { floating = true }},

   -- -- Add titlebars to normal clients and dialogs
   -- { rule_any = {type = { "normal", "dialog" }
   --   }, properties = { titlebars_enabled = true }
   -- },


   -- Tag names
   -- names = { "  ", "  ", "  ", "  ", "  "},

   -- Set Firefox to always map on the tag named "2" on screen 1.
   { rule = {
        class = "Firefox"
   }, properties = {
        screen = 1, tag = "  " } },
   { rule = {
        class = "Thunderbird"
   }, properties = {
        screen = 1, tag = "  " } },
   { rule = {
        class = "Emacs",
   }, properties = {
        screen = 1, tag = "  " } },
   { rule = {
        class = "Sonata",
   }, properties = {
        screen = 1, tag = "  " } },
   { rule = {
        class = "Transmission",
   }, properties = {
        screen = 1, tag = "  " } },

   -- { rule = { class = "Gimp", role = "gimp-image-window" },
   --   properties = { maximized = true } },    
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
                         -- Set the windows at the slave,
                         -- i.e. put it at the end of others instead of setting it master.
                         -- if not awesome.startup then awful.client.setslave(c) end

                         if awesome.startup and
                            not c.size_hints.user_position
                         and not c.size_hints.program_position then
                            -- Prevent clients from being unreachable after screen count changes.
                            awful.placement.no_offscreen(c)
                         end
end)

-- -- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal("request::titlebars", function(c)
--     -- buttons for the titlebar
--     local buttons = awful.util.table.join(
--         awful.button({ }, 1, function()
--             client.focus = c
--             c:raise()
--             awful.mouse.client.move(c)
--         end),
--         awful.button({ }, 3, function()
--             client.focus = c
--             c:raise()
--             awful.mouse.client.resize(c)
--         end)
--     )

--     awful.titlebar(c) : setup {
--         { -- Left
--             awful.titlebar.widget.iconwidget(c),
--             buttons = buttons,
--             layout  = wibox.layout.fixed.horizontal
--         },
--         { -- Middle
--             { -- Title
--                 align  = "center",
--                 widget = awful.titlebar.widget.titlewidget(c)
--             },
--             buttons = buttons,
--             layout  = wibox.layout.flex.horizontal
--         },
--         { -- Right
--             awful.titlebar.widget.floatingbutton (c),
--             awful.titlebar.widget.maximizedbutton(c),
--             awful.titlebar.widget.stickybutton   (c),
--             awful.titlebar.widget.ontopbutton    (c),
--             awful.titlebar.widget.closebutton    (c),
--             layout = wibox.layout.fixed.horizontal()
--         },
--         layout = wibox.layout.align.horizontal
--     }
-- end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
                         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                         and awful.client.focus.filter(c) then
                            client.focus = c
                         end
end)

client.connect_signal("focus",
                      function(c)
                         c.border_color = beautiful.border_focus
                      end
)
client.connect_signal("unfocus",
                      function(c)
                         c.border_color = beautiful.border_normal
                      end
)
-- }}}


-- Autostart applications {{{
awful.spawn.with_shell("redshift-gtk")
awful.spawn.with_shell("connman-ui-gtk")
-- awful.spawn.with_shell("dropbox")
-- awful.spawn.with_shell("blueman-manager &")
--}}}
