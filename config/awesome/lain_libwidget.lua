
------------------------------------
------- Widget library -------------
------------------------------------


local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
-- local lain = require("lain")


-- {{{ Colors
colors = {
   black	= '<span color="#202020" >',
   white	= '<span color="#cccccc" >',
   cyan	        = '<span color="#89b6e2" >',
   red  	= '<span color="#e77171" >',
   green	= '<span color="#93d44f" >',
   orange	= '<span color="#eab93d" >',
   violet	= '<span color="#A26FE9" >',
   yellow       = '<span color="#DFDF09" >',
   tuerkis      = '<span color="#0BBEBB" >',
   mony_base3 = '<span color="#002b36" >',
   mony_base2 = '<span color="#073642" >',
   mony_base1 = '<span color="#586e75" >',
   mony_base0 = '<span color="#657b83" >',
   mony_base00 = '<span color="#839496" >',
   mony_base01 = '<span color="#93a1a1" >',
   mony_base02 = '<span color="#eee8d5" >',
   mony_base03 = '<span color="#fdf6e3" >',
   mony_yellow = '<span color="#b58900" >',
   mony_orange = '<span color="#cb4b16" >',
   mony_red = '<span color="#dc322f" >',
   mony_magenta = '<span color="#d33682" >',
   mony_violet = '<span color="#6c71c4" >',
   mony_blue = '<span color="#268bd2" >',
   mony_cyan = '<span color="#2aa198" >',
   mony_green = '<span color="#859900" >',
   null	        = '</span>'
}

bgcolors = {
   black	= '#202020',
   white	= '#cccccc',
   cyan	        = '#89b6e2',
   red  	= '#e77171',
   green	= '#93d44f',
   orange	= '#eab93d',
   violet	= '#A26FE9',
   yellow       = '#DFDF09',
   tuerkis      = '#0BBEBB',
   mony_base3 = '#002b36',
   mony_base2 = '#073642',
   mony_base1 = '#586e75',
   mony_base0 = '#657b83',
   mony_base00 = '#839496',
   mony_base01 = '#93a1a1',
   mony_base02 = '#eee8d5',
   mony_base03 = '#fdf6e3',
   mony_yellow = '#b58900',
   mony_orange = '#cb4b16',
   mony_red = '#dc322f',
   mony_magenta = '#d33682',
   mony_violet = '#6c71c4',
   mony_blue = '#268bd2',
   mony_cyan = '#2aa198',
   mony_green = '#859900'
}

-- {{{ Icon Dir
-- icon_dir = awful.util.getdir("config") .. "/icons/white/"
-- }}}


-- icons
icon_sbdir = awful.util.getdir("config") .. "/themes/starbreaker/icons/"

icons = {}
icons.widget_temp                   = icon_sbdir .. "/temp.png"
icons.widget_uptime                 = icon_sbdir .. "/ac.png"
icons.widget_cpu                    = icon_sbdir .. "/cpu.png"
icons.widget_weather                = icon_sbdir .. "/dish.png"
icons.widget_fs                     = icon_sbdir .. "/fs.png"
icons.widget_mem                    = icon_sbdir .. "/mem.png"
icons.widget_fs                     = icon_sbdir .. "/fs.png"
icons.widget_note                   = icon_sbdir .. "/note.png"
icons.widget_note_on                = icon_sbdir .. "/note_on.png"
icons.widget_netdown                = icon_sbdir .. "/net_down.png"
icons.widget_netup                  = icon_sbdir .. "/net_up.png"
icons.widget_mail                   = icon_sbdir .. "/mail.png"
icons.widget_batt                   = icon_sbdir .. "/bat.png"
icons.widget_clock                  = icon_sbdir .. "/clock.png"
icons.widget_vol                    = icon_sbdir .. "/spkr.png"

-- {{{ Wibox
markup = lain.util.markup
space3 = markup.font("Tamsyn 3", " ")
space2 = markup.font("Tamsyn 2", " ")


-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "de", "neo" }, { "de", "basic" } }
kbdcfg.current = 1  -- neo is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_markup(markup(bgcolors.mony_base0, " " .. kbdcfg.layout[kbdcfg.current][2] .. " "))

kbdcfg.switch = function ()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  -- kbdcfg.widget:set_text(" " .. t[2] .. " ")
  kbdcfg.widget:set_markup(markup(bgcolors.mony_base0, " " ..t[2] .. " "))
  os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
    
-- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))



-- WIDGET LIBRARY, STOLEN FROM STARBREAKER


-- Textclock
clockicon = wibox.widget.imagebox(icons.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%a, %d %B ") .. markup("#eee8d5", ">") .. markup("#de5e1e", " %H:%M "))

-- Calendar
lain.widgets.calendar:attach(mytextclock, { 
    font_size = 10,
    font = "Inconsolata",
    fg = bgcolors.mony_base0,
    bg = bgcolors.mony_base2
})

-- -- CPU
cpuicon_image = wibox.widget.imagebox()
cpuicon_image:set_image(icon_sbdir .. "cpu.png")
cpuicon = wibox.widget.background()
cpuicon:set_widget(cpuicon_image)

cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
    end
})

-- Coretemp
tempicon = wibox.widget.imagebox(icons.widget_temp)
tempwidget = lain.widgets.temp({tempfile = "/sys/class/thermal/thermal_zone1/temp",
    settings = function()
        widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
    end
})


-- Battery
baticon = wibox.widget.imagebox(icons.widget_batt)
batwidget = lain.widgets.bat({
      timeout = 15,
      battery = "BAT0",
      notify = "on",
      settings = function()
         if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
         else
            bat_now.perc = bat_now.perc .. "% "
         end
         widget:set_text(bat_now.perc)
      end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
      settings = function()
         perc = bat_now.perc .. "% "
         if bat_now.ac_status == 1 then
            perc = perc .. "Plug "
         end
         widget:set_text(perc)
      end
})

-- ALSA volume
volicon = wibox.widget.imagebox(icons.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
    end
})

-- MEM
memicon = wibox.widget.imagebox(icons.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
    end
})

-- Spacer
spacer = wibox.widget.textbox(" ")

-- }}}
