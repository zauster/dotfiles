
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")
local lain = require("lain")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- local blingbling = require("blingbling")
-- local vicious = require("vicious")
-- local bashets = require("bashets")
-- local scratch = require("scratch")

-- Personal libraries
local libwidget = require("libwidget")
local spacers = require("spacer_arrows")

local capi = {
     screen = screen,
     tag = tag,
     timer = timer,
     mouse = mouse,
     client = client,
     keygrabber = keygrabber
     }

-- {{{ Error handling

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
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Move mouse out of the way
local safeCoords = { x = 512, y = 0}
-- Flag to tell Awesome whether to do this at startup.
-- local moveMouseOnStartup = true

home = os.getenv("HOME")
confdir = home .. "/dotfiles/.config/awesome"
themes = confdir .. "/themes"
icons = themes .. "/solarized/icons"

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/home/reitero/.config/awesome/themes/reitero/theme.lua")
-- beautiful.init("/home/reitero/.config/awesome/themes/solarized/theme.lua")
beautiful.init("/home/reitero/.config/awesome/themes/starbreaker/theme.lua")

naughty.config.defaults.fg               = theme.fg_normal -- or '#ffffff'
-- beautiful.fg_focus or '#ffffff'
naughty.config.defaults.bg               = theme.bg_normal
-- beautiful.bg_focus or '#535d6c'
naughty.config.presets.border_color     = theme.bg_urgent
naughty.config.defaults.border_color     = theme.bg_urgent
-- beautiful.border_focus or '#535d6c'
naughty.config.defaults.border_width     = 1
naughty.config.defaults.hover_timeout    = nil


-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

terminal = "urxvt -name DURxvt"
-- editor = os.getenv("EDITOR") or "nano"
editor = "emacsen"
-- editor_cmd = terminal .. " -e " .. editor
editor_cmd = terminal .. " -e emacsclient -t"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier
}
-- }}}


-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = { 
   names  = { " main", " www ", "emacs", "media"},
   layouts = { layouts[1], layouts[4], layouts[4], layouts[1] }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layouts)
    -- tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- require('freedesktop.utils')
--   freedesktop.utils.terminal = terminal  -- default: "xterm"
--   freedesktop.utils.icon_theme = { 'Faenza', 'Faience' } -- look inside /usr/share/icons/, default: nil (don't use icon theme)
-- require('freedesktop.menu')

-- {{{ Right-Click Context menu
function mvscr()
   local scrs = {}
   for s = 1, capi.screen.count() do
      scr = 'Screen ' .. s
      scrs[s] = { scr, function () awful.client.movetoscreen(c,s) end }
      scrn = awful.util.table.join(scrs, {
                                      {"Next Screen",
                                       function() awful.client.movetoscreen(c,c.screen+1) end
                                      },
                                      {"Prev Screen",
                                       function() awful.client.movetoscreen(c,c.screen-1) end
                                      }})
   end
   return scrn
end

function mvtag()
   local tags_n = {}
   for t = 1, tag.instances() do --FIXME replace "tag.instances()" with the numbers of tags on mouse.screen
      tagm = 'Tag ' .. t
      tags_n[t] = { tagm, function() awful.client.movetotag(tags[client.focus.screen][t]) end }
      tags_np = awful.util.table.join( tags_n, {
                                          {"Next tag",
                                           function (c)
                                              local curidx = awful.tag.getidx()
                                              if curidx == 9 then
                                                 awful.client.movetotag(tags[client.focus.screen][1])
                                              else
                                                 awful.client.movetotag(tags[client.focus.screen][curidx + 1])
                                              end
                                           end
                                          },
                                          {"Prev tag",
                                           function (c)
                                              local curidx = awful.tag.getidx()
                                              if curidx == 1 then
                                                 awful.client.movetotag(tags[client.focus.screen][9])
                                              else
                                                 awful.client.movetotag(tags[client.focus.screen][curidx - 1])
                                              end
                                           end
                                          }
                                               })
      
   end
   return tags_np
end

function ttag()
   local tags_n = {}
   for t = 1, tag.instances() do --FIXME replace "tag.instances()" with the numbers of tags on mouse.screen
      tagm = 'Toggle Tag ' .. t
      tags_n[t] = { tagm, function() awful.client.toggletag(tags[client.focus.screen][t]) end }
   end
   return tags_n
end

function clsmenu(args)
   _menu = self or {}
   local cls = capi.client.get()
   local cls_t = {}
   for k, c in pairs(cls) do
      cls_t[#cls_t + 1] = {
         awful.util.escape(c.name) or "",
         function ()
            if not c:isvisible() then
               awful.tag.viewmore(c:tags(), c.screen)
            end
            capi.client.focus = c
            c:raise()
         end,
         c.icon }
   end
   return cls_t
end

function showNavMenu(menu, args)
   local cls_t = clsmenu(cls)
   local tag_n = mvtag()
   local tag_t = ttag()
   local scr_n = mvscr()

   if not menu then
      menu = {}
   end
   c = capi.client.focus

   fclient = {
      {
         "Close", --✖ 
         function() c:kill() end
      },
      {
         (c.minimized and "Restore") or "Minimize", --⇱ ⇲ 
         function() c.minimized = not c.minimized end
      },	
      {
         (c.maximized_horizontal and "Restore") or "[M] Maximize",
         function () c.maximized_horizontal = not c.maximized_horizontal c.maximized_vertical = not c.maximized_vertical end
      },
      {
         (c.sticky and "Un-Stick") or "[S] Stick", --⚫ ⚪ 
         function() c.sticky = not c.sticky end
      },
      {
         (c.ontop and "Offtop") or "[T] Ontop", --⤼ ⤽ 
         function()
            c.ontop = not c.ontop
            if c.ontop then c:raise() end
         end
      },
      {
         ((awful.client.floating.get(c) and "Tile") or "[F] Float"), --▦ ☁ 
         function() awful.client.floating.toggle(c) end
      },
      {"Master",
       function() c:swap(awful.client.getmaster(1)) end
      },
      {"Slave",
       function() awful.client.setslave(c) end
      }
   }
   local mynav = {
      {awful.util.escape(c.class),
       fclient, c.icon
      },
      {"Move to Tag",
       tag_n
      },
      {"Toggle Tag",
       tag_t
      },
      {"Move to Screen",
       scr_n
      },
      {"Clients",
       cls_t
      },
   }
   menu.items = mynav

   local m = awful.menu.new(menu)
   m:show(args)
   return m
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
-- myawesomemenu = {
--    { "manual", terminal .. " -e man awesome" },
--    { "edit config", editor_cmd .. " " .. awesome.conffile },
--    { "restart", awesome.restart },
--    { "quit", awesome.quit }
-- }

myawesomemenu = {
   { "manual", terminal .. " -e man awesome &" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "logout", awesome.quit },
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
                                    -- { "graphics", graphicsmenu },
                                    { "editor", editormenu },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- local orglendar = require('orglendar')
-- orglendar.files = { "/home/reitero/Dropbox/Org/arbeit.org",
--                     "/home/reitero/Dropbox/Org/else.org",
--                     "/home/reitero/Dropbox/Org/notes.org",
--                     "/home/reitero/Dropbox/Org/studium.org",
--                     "/home/reitero/Dropbox/Org/thesis.org"  }
-- orglendar.register(mytextclock)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 2, function (c) c:kill()                         end),
                     awful.button({ }, 3, function (c)
                                              client.focus = c
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                 instance = showNavMenu() -- awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20, fg = theme.fg_normal })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(space) 
    left_layout:add(mylayoutbox[s])
    left_layout:add(space) 
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(space)

    if s == 1 then right_layout:add(wibox.widget.systray()) end

    -- Keymap widget
    right_layout:add(kbdcfg.widget)

    -- Memory widget
    right_layout:add(memicon)
    right_layout:add(memwidget)

    -- CPU widget
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)

    -- Volume widget
    right_layout:add(volicon)
    right_layout:add(volumewidget)

    -- Temp widget
    right_layout:add(tempicon)
    right_layout:add(tempwidget)

    -- Battery widget
    right_layout:add(baticon)
    right_layout:add(batwidget)

    -- Clock widget
    right_layout:add(clockicon)
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end) --,
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}



-- {{{ Key bindings oliverized version
globalkeys = awful.util.table.join(
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "x", awful.tag.history.restore),
   awful.key({ modkey,           }, "Tab",
             function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey,           }, "r",
             function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey,           }, "v", function () mymainmenu:show({keygrabber=true}) end),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "n", function () awful.client.swap.byidx(  1)    end),
   awful.key({ modkey, "Shift"   }, "r", function () awful.client.swap.byidx( -1)    end),
   awful.key({ modkey,           }, "b", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey,           }, "ö", awful.client.urgent.jumpto),


   -- Standard program
   awful.key({ modkey,           }, "d", function () awful.util.spawn(terminal) end),
   awful.key({ modkey,           }, "t", function () awful.util.spawn("urxvt -name LURxvt") end),
   awful.key({ modkey,           }, "w", awesome.restart),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit),

   awful.key({ modkey }, "l",          function () awful.tag.incmwfact( 0.05) end),
   awful.key({ modkey }, "h",          function () awful.tag.incmwfact(-0.05) end),
   awful.key({ modkey, "Shift" }, "l", function () awful.client.incwfact(-0.05) end),
   awful.key({ modkey, "Shift" }, "h", function () awful.client.incwfact( 0.05) end),

   -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

   awful.key({ modkey, "Control" }, "n", awful.client.restore),

   -- Prompt
   awful.key({ modkey },            "u",     function () mypromptbox[mouse.screen]:run() end),

   awful.key({ modkey }, "p", function() menubar.show() end)
                                    )

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey,           }, "Escape", function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   -- awful.key({ modkey,           }, "o",      function (c) awful.client.movetoscreen(c,c.screen-1) end),
   awful.key({ modkey,           }, "s",      function (c) awful.client.movetoscreen(c,c.screen+1) end),
   awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
   -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),

   awful.key({ modkey,           }, "n",
             function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
             end),
   awful.key({ modkey,           }, "m",
             function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical   = not c.maximized_vertical
             end),

-- Move client to another tag
   awful.key({ modkey, "Control"   }, "Left",
     function (c)
         local curidx = awful.tag.getidx()
         if curidx == 1 then
             awful.client.movetotag(tags[client.focus.screen][4])
         else
             awful.client.movetotag(tags[client.focus.screen][curidx - 1])
         end
     end),
   awful.key({ modkey, "Control"   }, "Right",
     function (c)
         local curidx = awful.tag.getidx()
         if curidx == 4 then
             awful.client.movetotag(tags[client.focus.screen][1])
         else
             awful.client.movetotag(tags[client.focus.screen][curidx + 1])
         end
     end)   
                                  )
                               

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


-- Custom keybindings
globalkeys = awful.util.table.join(globalkeys, 
                                   awful.key({ modkey,  }, "#94", function() awful.util.spawn("pcmanfm") end),
                                   awful.key({  }, "XF86Explorer", function() awful.util.spawn("pcmanfm") end),
                                   awful.key({ modkey,  }, "i", function () awful.util.spawn("chromium") end),
                                   awful.key({ modkey,  }, "a", function () awful.util.spawn("firefox") end),
                                   awful.key({ modkey,  }, "o", function () awful.util.spawn("thunderbird") end),
                                   awful.key({ modkey,  }, "e", function () awful.util.spawn("emacsen") end),
                                   awful.key({ modkey,  }, "#52", function () awful.util.spawn("sonata") end),
                                   awful.key({ }, "XF86MonBrightnessDown",       function () awful.util.spawn("xbacklight -dec 7") end),
                                   awful.key({ }, "XF86MonBrightnessUp",         function () awful.util.spawn("xbacklight -inc 7") end),
                                   awful.key({ }, "XF86AudioMute",       function () awful.util.spawn("amixer set Master toggle") end),
                                   awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 3%+", false) end),
                                   awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 3%-", false) end)
)


-- Set keys
root.keys(globalkeys)
-- compare default and oliverized keybindings to be able to delete the
-- default key definition
-- }}}


-- {{{ Rules
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = true,
                    keys = clientkeys,
                    buttons = clientbuttons } },
   { rule = { class = "pinentry" },
     properties = { floating = true } },
   -- Set Firefox to always map on tags number 2 of screen 1.
   { rule = { class = "Firefox" },
     properties = { tag = tags[1][2] } },
   { rule = { class = "Chromium" },
     properties = { tag = tags[1][2] } },
   { rule = { class = "Transmission" },
     properties = { tag = tags[1][4] } },
   { rule = { class = "Thunderbird" },
     properties = { tag = tags[1][2] } },
   { rule = { class = "Emacs" },
     properties = { tag = tags[1][3] } },
   { rule = { class = "Blueman" },
     properties = { tag = tags[1][4] } },
   { rule = { class = "Sonata" },
     properties = { tag = tags[1][4] } },
   { rule = { class = "Skype" },
     properties = { tag = tags[1][4] },
     callback = awful.client.setslave  },
   { rule = { instance = "Download" },
     properties = { floating = true }, },      
   { rule = { class = "gimp" },
     properties = { floating = true } },
   { rule = { class = "Plugin-container" },
     properties = { floating = true } },
   { rule = { class = "Exe" },
     properties = { floating = true } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart programs
function run_once(cmd)
   findme = cmd
   firstspace = cmd:find(" ")
   if firstspace then
      findme = cmd:sub(0, firstspace-1)
   end
   awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("dropbox")
run_once("connman-ui-gtk")
run_once("connman-notify")
run_once("blueman-manager")
run_once("redshift-gtk")
-- }}}
