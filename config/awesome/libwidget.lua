
-- ----------------------------------------
-- ----- Widget library -------------------
-- ----------------------------------------


local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- local vicious = require("vicious")
local naughty = require("naughty")
local lain = require("lain")


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
   colors.null	        = '</span>'
-- }}}

-- {{{ Icon Dir
icon_dir = awful.util.getdir("config") .. "/icons/white/"
-- }}}

-- -- Separator for right side
-- separator = wibox.widget.textbox()
-- separator:set_markup(colors.black .. " |" .. colors.null)

-- -- Separator for left side
-- separatorleft = wibox.widget.textbox()
-- separatorleft:set_markup(colors.white .. "|" .. colors.null)


-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "de", "neo" }, { "de", "basic" } }
kbdcfg.current = 1  -- neo is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][2] .. " ")

kbdcfg.switch = function ()
  kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  kbdcfg.widget:set_text(" " .. t[2] .. " ")
  os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
    
-- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))


-- 
-- WIDGET LIBRARY, STOLEN FROM SARDINA
-- 

-- {{{ Wibox
markup = lain.util.markup
blue   = "#80CCE6"
space3 = markup.font("Tamsyn 3", " ")
space2 = markup.font("Tamsyn 2", " ")


-- Menu icon
awesome_icon = wibox.widget.imagebox()
awesome_icon:set_image(beautiful.awesome_icon)
awesome_icon:buttons(awful.util.table.join( awful.button({ }, 1, function() mymainmenu:toggle() end)))

-- -- Clock
-- mytextclock = awful.widget.textclock(" %a %d %b, %H:%M  ")

-- clock_icon_image = wibox.widget.imagebox()
-- clock_icon_image:set_image(icon_dir .. "info_01.png")
-- clock_icon = wibox.widget.background()
-- clock_icon:set_widget(clock_icon_image)
-- clock_icon:set_bg(bgcolors.mony_base0)

-- clockwidget = wibox.widget.background()
-- clockwidget:set_widget(mytextclock)
-- -- clockwidget:set_bgimage(beautiful.widget_bg)
-- lain.widgets.calendar:attach(clockwidget, { font = "inconsolata", font_size = 10, fg = bgcolors.mony_base0, bg = bgcolors.mony_base3})

-- -- Calendar
-- -- mytextcalendar = awful.widget.textclock(markup("#FFFFFF", space3 .. "%d %b<span font='Tamsyn 5'> </span>"))
-- -- calendar_icon = wibox.widget.imagebox()
-- -- calendar_icon:set_image(beautiful.calendar)
-- -- calendarwidget = wibox.widget.background()
-- -- calendarwidget:set_widget(mytextcalendar)
-- -- calendarwidget:set_bgimage(beautiful.widget_bg)
-- -- lain.widgets.calendar:attach(calendarwidget, { font = "inconsolata", font_size = 10, fg = bgcolors.mony_base0, bg = bgcolors.mony_base3})


-- -- Battery
-- baticon_image = wibox.widget.imagebox()
-- baticon_image:set_image(icon_dir .. "bat_full_02.png")
-- baticon = wibox.widget.background()
-- baticon:set_widget(baticon_image)
-- baticon:set_bg(bgcolors.mony_base0)

-- batwidget = lain.widgets.bat({
--     settings = function()
--         if bat_now.perc == " N/A " then
--             bat_now.perc = " AC "
--         else
--             bat_now.perc = " Bat " .. bat_now.perc .. "%  "
--         end
--         widget:set_text(bat_now.perc)
--     end
-- })

-- -- ALSA volume bar
-- -- myvolumebar = lain.widgets.alsabar({
-- --     ticks  = true,
-- --     width  = 80,
-- --     height = 10,
-- --     colors = {
-- --         background = "#383838",
-- --         unmute     = "#80CCE6",
-- --         mute       = "#FF9F9F"
-- --     },
-- --     notifications = {
-- --         font      = "Tamsyn",
-- --         font_size = "12",
-- --         bar_size  = 32
-- --     }
-- -- })
-- -- alsamargin = wibox.layout.margin(myvolumebar.bar, 5, 8, 80)
-- -- wibox.layout.margin.set_top(alsamargin, 12)
-- -- wibox.layout.margin.set_bottom(alsamargin, 12)
-- -- volumewidget = wibox.widget.background()
-- -- volumewidget:set_widget(alsamargin)
-- -- volumewidget:set_bgimage(beautiful.widget_bg)

-- -- CPU
-- cpu_widget = lain.widgets.cpu({
--     settings = function()
--         widget:set_markup(" CPU " .. cpu_now.usage .. "%  ")
--     end
-- })
-- cpuwidget = wibox.widget.background()
-- cpuwidget:set_widget(cpu_widget)
-- cpuwidget:set_bgimage(beautiful.widget_bg)


-- cpuicon_image = wibox.widget.imagebox()
-- cpuicon_image:set_image(icon_dir .. "cpu.png")
-- cpuicon = wibox.widget.background()
-- cpuicon:set_widget(cpuicon_image)
-- cpuicon:set_bg(bgcolors.mony_base1)


-- -- MEM
-- -- memicon = wibox.widget.imagebox(beautiful.widget_mem)
-- memwidget = lain.widgets.mem({
--     settings = function()
--         widget:set_markup(" " ..mem_now.used .. "M  ")
--     end
-- })

-- memicon_image = wibox.widget.imagebox()
-- memicon_image:set_image(icon_dir .. "mem.png")
-- memicon = wibox.widget.background()
-- memicon:set_widget(memicon_image)
-- memicon:set_bg(bgcolors.mony_base0)


-- -- Weather
-- -- yawn = lain.widgets.yawn(551801) -- Vienna = 551801

-- -- Weather
-- weathericon_image = wibox.widget.imagebox(beautiful.widget_weather)
-- weathericon_image:set_image(icon_dir .. "info_01.png")
-- weathericon = wibox.widget.background()
-- weathericon:set_widget(weathericon_image)
-- weathericon:set_bg(bgcolors.mony_base0)

-- yawn = lain.widgets.yawn(551801, {
--     settings = function()
--         widget:set_markup(" " .. forecast:lower() .. " @ " .. units .. "°C  ")
--     end
-- })

-- -- Temp Widget
-- temp_widget = lain.widgets.temp({tempfile = "/sys/class/thermal/thermal_zone1/temp",
--       settings = function()
--          widget:set_markup(" Temp " .. coretemp_now .. " C  ")
--       end
-- })
-- tempwidget = wibox.widget.background()
-- tempwidget:set_widget(temp_widget)
-- tempwidget:set_bgimage(beautiful.widget_bg)

-- tempicon_image = wibox.widget.imagebox()
-- tempicon_image:set_image(icon_dir .. "temp.png")
-- tempicon = wibox.widget.background()
-- tempicon:set_widget(tempicon_image)
-- tempicon:set_bg(bgcolors.mony_base1)

-- -- Net
-- netdown_icon = wibox.widget.imagebox()
-- netdown_icon:set_image(beautiful.net_down)
-- netup_icon = wibox.widget.imagebox()
-- netup_icon:set_image(beautiful.net_up)
-- netwidget = lain.widgets.net({
--     settings = function()
--         widget:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received .. " - "
--                           .. net_now.sent .. space2)
--     end
-- })
-- networkwidget = wibox.widget.background()
-- networkwidget:set_widget(netwidget)
-- networkwidget:set_bgimage(beautiful.widget_bg)


-- Separators
first = wibox.widget.textbox('<span font="Tamsyn 4"> </span>')
last = wibox.widget.imagebox()
last:set_image(beautiful.last)
spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr_small = wibox.widget.imagebox()
spr_small:set_image(beautiful.spr_small)
spr_very_small = wibox.widget.imagebox()
spr_very_small:set_image(beautiful.spr_very_small)
spr_right = wibox.widget.imagebox()
spr_right:set_image(beautiful.spr_right)
spr_bottom_right = wibox.widget.imagebox()
spr_bottom_right:set_image(beautiful.spr_bottom_right)
spr_left = wibox.widget.imagebox()
spr_left:set_image(beautiful.spr_left)
bar = wibox.widget.imagebox()
bar:set_image(beautiful.bar)
bottom_bar = wibox.widget.imagebox()
bottom_bar:set_image(beautiful.bottom_bar)



-- 
-- WIDGET LIBRARY, STOLEN FROM STARBREAKER
--

-- icons
icon_sbdir = awful.util.getdir("config") .. "/themes/starbreaker/icons/"

icons_widget_temp                   = icon_sbdir .. "/temp.png"

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

-- Textclock
clockicon = wibox.widget.imagebox(icons.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%a, %d %B ") .. markup("#eee8d5", ">") .. markup("#de5e1e", " %H:%M "))
-- mytextclock = awful.widget.textclock(markup("#7788af", "%d %B %Y ") .. markup("#eee8d5", ">") .. markup("#de5e1e", " %H:%M "))

-- Calendar
lain.widgets.calendar:attach(mytextclock, { 
    font_size = 10,
    -- font = "Source Code Pro Medium" 
    font = "Inconsolata" 
    })

-- Weather
-- weathericon = wibox.widget.imagebox(icons.widget_weather)
-- yawn = lain.widgets.yawn(12764646, {
--    settings = function()
--        widget:set_markup(markup("#eca4c4", forecast:lower() .. " @ " .. units .. "°C "))
--    end
-- })

-- / fs
fsicon = wibox.widget.imagebox(icons.widget_fs)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
    end
})

-- --[[ Mail IMAP check
-- -- commented because it needs to be set before use
-- mailicon = wibox.widget.imagebox()
-- mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
-- mailwidget = lain.widgets.imap({
--     timeout  = 180,
--     server   = "server",
--     mail     = "mail",
--     password = "keyring get mail",
--     settings = function()
--         if mailcount > 0 then
--             mailicon:set_image(icons.widget_mail)
--             widget:set_markup(markup("#cccccc", mailcount .. " "))
--         else
--             widget:set_text("")
--             mailicon:set_image(nil)
--         end
--     end
-- })
-- ]]

-- -- CPU
cpuicon_image = wibox.widget.imagebox()
cpuicon_image:set_image(icon_sbdir .. "cpu.png")
cpuicon = wibox.widget.background()
cpuicon:set_widget(cpuicon_image)

-- -- cpuicon:set_image(icons.widget_cpu)
-- cpuicon:set_image(icon_sbdir .. "/cpu.png")

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

-- -- Temp Widget
-- temp_widget = lain.widgets.temp({
--       settings = function()
--          widget:set_markup(" Temp " .. coretemp_now .. " C  ")
--       end
-- })
-- tempwidget = wibox.widget.background()
-- tempwidget:set_widget(temp_widget)
-- tempwidget:set_bgimage(beautiful.widget_bg)


-- Battery
baticon = wibox.widget.imagebox(icons.widget_batt)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_text(bat_now.perc)
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

-- Net
-- netdownicon = wibox.widget.imagebox(icons.widget_netdown)
-- --netdownicon.align = "middle"
-- netdowninfo = wibox.widget.textbox()
-- netupicon = wibox.widget.imagebox(icons.widget_netup)
-- --netupicon.align = "middle"
-- netupinfo = lain.widgets.net({
--     settings = function()
--         if iface ~= "network off" and string.match(yawn.widget._layout.text, "N/A")
--         then
--             yawn.fetch_weather()
--         end

--         widget:set_markup(markup("#e54c62", net_now.sent .. " "))
--         netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
--     end
-- })

-- MEM
memicon = wibox.widget.imagebox(icons.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
    end
})

-- MPD
mpdicon = wibox.widget.imagebox()
mpdwidget = lain.widgets.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(icons.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(nil)
        end
        widget:set_markup(markup("#e54c62", artist) .. markup("#b2b2b2", title))
    end
})

-- Spacer
spacer = wibox.widget.textbox(" ")

-- }}}
