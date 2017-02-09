
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
   awful.key({ modkey, }, "Left", awful.tag.viewprev ),
   awful.key({ modkey, }, "Right", awful.tag.viewnext ),
   awful.key({ modkey, }, "x", awful.tag.history.restore),
   awful.key({ modkey, }, "Tab",
      function ()
         awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}),
   -- awful.key({ modkey, }, "Tab",
   -- function ()
   -- awful.client.focus.byidx( 1)
   -- if client.focus then client.focus:raise() end
   -- end),
   -- awful.key({ modkey, }, "r",
   -- function ()
   -- awful.client.focus.byidx(-1)
   -- if client.focus then client.focus:raise() end
   -- end),
   awful.key({ modkey, }, "v", function () mymainmenu:show({keygrabber=true}) end),

   -- Layout manipulation
   awful.key({ modkey, "Shift" }, "n", function () awful.client.swap.byidx( 1) end),
   awful.key({ modkey, "Shift" }, "r", function () awful.client.swap.byidx( -1) end),
   awful.key({ modkey, }, "b", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey, }, "ö", awful.client.urgent.jumpto),


   -- Standard program
   awful.key({ modkey, }, "d", function () awful.spawn(terminal) end),
   awful.key({ modkey, }, "t", function () awful.spawn("urxvt -name LURxvt") end),
   awful.key({ modkey, }, "w", awesome.restart),
   awful.key({ modkey, "Shift" }, "q", awesome.quit),

   awful.key({ modkey }, "l", function () awful.tag.incmwfact( 0.05) end),
   awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end),
   awful.key({ modkey, "Shift" }, "l", function () awful.client.incwfact(-0.05) end),
   awful.key({ modkey, "Shift" }, "h", function () awful.client.incwfact( 0.05) end),

   -- awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1) end),
   -- awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1) end),
   awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1) end),
   awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1) end),
   awful.key({ modkey, }, "space", function () awful.layout.inc(layouts, 1) end),
   awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end),

   -- awful.key({ modkey, "Control" }, "n", awful.client.restore),
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
   awful.key({ modkey }, "u", function () mypromptbox[1]:run() end),
   -- better way would be this:
   -- awful.key({ modkey }, "u", function () awful.screen.focused().mypromptbox:run() end,
   -- {description = "run prompt", group = "launcher"}),

   awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
   -- awful.key({ modkey, }, "f", function (c) c.fullscreen = not c.fullscreen end),
   awful.key({ modkey, }, "f",
      function (c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   awful.key({ modkey, }, "Escape", function (c) c:kill() end),
   awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   -- awful.key({ modkey, }, "s", function (c) awful.client.movetoscreen(c, c.screen + 1) end),
   awful.key({ modkey, }, "s", function (c) c:move_to_screen() end,
      {description = "move to screen", group = "client"}),
   
   awful.key({ modkey, "Shift" }, "r", function (c) c:redraw() end),
   -- awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end),

   awful.key({ modkey, }, "n",
      function (c)
         -- The client currently has the input focus, so it cannot be
         -- minimized, since minimized clients can't have the focus.
         c.minimized = true
   end),
   awful.key({ modkey, }, "m",
      function (c)
         c.maximized_horizontal = not c.maximized_horizontal
         c.maximized_vertical = not c.maximized_vertical
   end),

   -- Move client to another tag
   awful.key({ modkey, "Control" }, "Left",
      function (c)
         local curidx = awful.tag.getidx()
         if curidx == 1 then
            awful.client.movetotag(tags[client.focus.screen][4])
         else
            awful.client.movetotag(tags[client.focus.screen][curidx - 1])
         end
   end),
   
   -- awful.key({ modkey, "Shift" }, "#" .. i + 9,
   --    function ()
   --       if client.focus then
   --          local tag = client.focus.screen.tags[i]
   --          if tag then
   --             client.focus:move_to_tag(tag)
   --          end
   --       end
   --    end,
   --    {description = "move focused client to tag #"..i, group = "tag"}),
   
   awful.key({ modkey, "Control" }, "Right",
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


-- Custom keybindings
globalkeys = awful.util.table.join(globalkeys, 
                                   awful.key({ modkey, }, "#94", function() awful.util.spawn("pcmanfm") end),
                                   awful.key({ }, "XF86Explorer", function() awful.util.spawn("pcmanfm") end),
                                   awful.key({ modkey, }, "i", function () awful.util.spawn("chromium") end),
                                   awful.key({ modkey, }, "a", function () awful.util.spawn("firefox") end),
                                   awful.key({ modkey, }, "o", function () awful.util.spawn("thunderbird") end),
                                   awful.key({ modkey, }, "e", function () awful.util.spawn("emacs") end),
                                   -- awful.key({ modkey, }, "e", function () awful.util.spawn("emacsen") end),
                                   awful.key({ modkey, }, "#52", function () awful.util.spawn("sonata") end),
                                   awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 7") end),
                                   awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 7") end),
                                   awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),
                                   awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 3%+", false) end),
                                   awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 3%-", false) end)
)


-- Set keys
root.keys(globalkeys)
-- compare default and oliverized keybindings to be able to delete the
-- default key definition
-- }}}
