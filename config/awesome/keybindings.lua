
local awful = require("awful")


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
                                   awful.key({ modkey,  }, "e", function () awful.util.spawn("emacs") end),
                                   -- awful.key({ modkey,  }, "e", function () awful.util.spawn("emacsen") end),
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
