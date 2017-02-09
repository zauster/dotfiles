

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")

-- graphwidth  = 120
-- graphheight = 20
-- pctwidth    = 40
-- netwidth    = 50
-- mpdwidth    = 365

-- Set the font.
function markupfont(font, text)
   return '<span font="'  .. tostring(font)  .. '">' .. tostring(text) ..'</span>'
end

-- Set the foreground.
function markupfg(color, text)
   return '<span foreground="' .. tostring(color) .. '">' .. tostring(text) .. '</span>'
end

-- Set the background.
function markupbg(color, text)
   return '<span background="' .. tostring(color) .. '">' .. tostring(text) .. '</span>'
end

function markupcolor(color, text)
   return '<span color="' .. tostring(color) .. '">' .. tostring(text) .. '</span>'
end

-- {{{ Textclock
-- clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markupcolor("#7788af", "%a, %d %B ") .. markupcolor("#eee8d5", ">") .. markupcolor("#de5e1e", " %H:%M "))

--- }}}


--- {{{ Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "de", "neo" }, { "de", "basic" } }
kbdcfg.current = 1  -- neo is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_markup(markupcolor('#657b83', " " .. kbdcfg.layout[kbdcfg.current][2] .. " "))

kbdcfg.switch = function ()
   kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
   local t = kbdcfg.layout[kbdcfg.current]
   -- kbdcfg.widget:set_text(" " .. t[2] .. " ")
   kbdcfg.widget:set_markup(markupcolor('#657b83', " " ..t[2] .. " "))
   os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end

-- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
                         awful.button({ }, 1, function () kbdcfg.switch() end)
))
--- }}}


--- {{{ CPU frequency

-- Cache
vicious.cache(vicious.widgets.cpu)
vicious.cache(vicious.widgets.cpuinf)

cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)

-- Core 0 %
cpuwidget = wibox.widget.textbox()
-- function cpuwidget:fit(box, w, h) return math.min(pctwidth, w), h end
vicious.register(cpuwidget, vicious.widgets.cpu, "$2%", 2)
--- }}}



--- {{{ Memory

-- Cache
vicious.cache(vicious.widgets.mem)

memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)

-- RAM %
memwidget = wibox.widget.textbox()
memwidget.width = pctwidth
vicious.register(memwidget, vicious.widgets.mem, "$1%", 5)

--- }}}



-- {{{ Volume
-- Cache
vicious.cache(vicious.widgets.volume)

-- Icon
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)

-- Volume %
volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume, "$1%", nil, "Master")

-- Buttons
volicon:buttons(awful.util.table.join(
                   awful.button({ }, 1,
                      function() awful.util.spawn("amixer -q set Master toggle", false) end
                   ),
                   awful.button({ }, 4,
                      function() awful.util.spawn("amixer -q set Master 3+% unmute", false) end
                   ),
                   awful.button({ }, 5,
                      function() awful.util.spawn("amixer -q set Master 3-% unmute", false) end
                   )
))
volumewidget:buttons(volicon:buttons())
-- }}}



-- {{{ Battery
-- Battery attributes
local bat_state  = ""
local bat_charge = 0
local bat_time   = 0
local blink      = true

-- Icon
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_batfull)

-- Charge %
batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat,
                 function(widget, args)
                    bat_state  = args[1]
                    bat_charge = args[2]
                    bat_time   = args[3]

                    if args[1] ~= "+" then 
                       if bat_charge > 70 then
                          baticon:set_image(beautiful.widget_batfull)
                       elseif bat_charge > 30 then
                          baticon:set_image(beautiful.widget_batmed)
                       elseif bat_charge > 10 then
                          baticon:set_image(beautiful.widget_batlow)
                       else
                          baticon:set_image(beautiful.widget_batempty)
                       end
                    else
                       baticon:set_image(beautiful.widget_ac)
                       if args[1] == "+" then
                          blink = not blink
                          if blink then
                             baticon:set_image(beautiful.widget_acblink)
                          end
                       end
                    end

                    return args[2] .. "%"
                 end,
                 nil,
                 "BAT0")

-- Buttons
function popup_bat()
   local state = ""
   if bat_state == "↯" then
      state = "Full"
   elseif bat_state == "↯" then
      state = "Charged"
   elseif bat_state == "+" then
      state = "Charging"
   -- elseif bat_state == "-" then
   --    state = "Discharging"
   elseif bat_state == "⌁" then
      state = "Not charging"
   else
      state = "Discharging"
   end
   
   naughty.notify {
      text = "Charge: " .. bat_charge .. "%\nState:  " .. state ..
         " (" .. bat_time .. ")", -- %\nbat_state: " .. bat_state,
      timeout = 5, hover_timeout = 0.5
   }
end
batwidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_bat)))
baticon:buttons(batwidget:buttons())
-- }}}
