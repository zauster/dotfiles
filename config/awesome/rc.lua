
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init(awful.util.getdir("config") .."/themes/starbreaker/theme.lua")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Personal libraries
local libwidget = require("libwidget")
local contextmenu = require("contextmenu")


space = wibox.widget.textbox()
space:set_text(" ")
pipe = wibox.widget.textbox()
pipe:set_text("|")


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

-- naughty.config.defaults.fg               = theme.fg_normal -- or '#ffffff'
-- -- beautiful.fg_focus or '#ffffff'
-- naughty.config.defaults.bg               = theme.bg_normal
-- -- beautiful.bg_focus or '#535d6c'
-- naughty.config.presets.border_color     = theme.bg_urgent
-- naughty.config.defaults.border_color     = theme.bg_urgent
-- -- beautiful.border_focus or '#535d6c'
-- naughty.config.defaults.border_width     = 1
-- naughty.config.defaults.hover_timeout    = nil


-- This is used later as the default terminal and editor to run.
-- terminal = "xterm"
-- editor = os.getenv("EDITOR") or "nano"
-- editor_cmd = terminal .. " -e " .. editor

terminal = "urxvt -name DURxvt"
editor = "emacsen"
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

    right_layout:add(pipe)
    
    -- -- Keymap widget
    -- right_layout:add(kbdcfg.widget)

    -- Memory widget
    -- right_layout:add(memicon)
    -- right_layout:add(memwidget)

    -- CPU widget
    -- right_layout:add(cpuicon)
    -- right_layout:add(cpuwidget)

    -- Volume widget
    -- right_layout:add(volicon)
    -- right_layout:add(volumewidget)

    -- Temp widget
    -- right_layout:add(tempicon)
    -- right_layout:add(tempwidget)

    -- -- Battery widget
    right_layout:add(baticon)
    right_layout:add(batwidget)

    -- -- Clock widget
    -- right_layout:add(clockicon)
    -- right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}


--
-- {{{ set the keybindings
local keybindings = require("keybindings")
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

-- -- {{{ Autostart programs

require("lfs") 
-- {{{ Run programm once
local function processwalker()
   local function yieldprocess()
      for dir in lfs.dir("/proc") do
        -- All directories in /proc containing a number, represent a process
        if tonumber(dir) ~= nil then
          local f, err = io.open("/proc/"..dir.."/cmdline")
          if f then
            local cmdline = f:read("*all")
            f:close()
            if cmdline ~= "" then
              coroutine.yield(cmdline)
            end
          end
        end
      end
    end
    return coroutine.wrap(yieldprocess)
end

local function run_once(process, cmd)
   assert(type(process) == "string")
   local regex_killer = {
      ["+"]  = "%+", ["-"] = "%-",
      ["*"]  = "%*", ["?"]  = "%?" }

   for p in processwalker() do
      if p:find(process:gsub("[-+?*]", regex_killer)) then
	 return
      end
   end
   return awful.util.spawn(cmd or process)
end
-- }}}

-- Usage Example
-- Use the second argument, if the programm you wanna start, 
-- differs from the what you want to search.
-- run_once("redshift", "nice -n19 redshift -l 51:14 -t 5700:4500")

run_once("dropbox")
run_once("connman-ui-gtk")
run_once("connman-notify")
run_once("blueman-manager")
run_once("redshift-gtk")
-- }}}
