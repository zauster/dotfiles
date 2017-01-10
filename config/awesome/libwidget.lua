

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")




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
