
----------------------------------------
------- Spacer Arrows ------------------
----------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")

home = os.getenv("HOME")
confdir = home .. "/dotfiles/.config/awesome"
themes = confdir .. "/themes"
icons = themes .. "/solarized/icons"

-- {{{ Spacers & Arrows

rbracket = wibox.widget.textbox()
rbracket:set_text("]")
lbracket = wibox.widget.textbox()
lbracket:set_text("[")
line = wibox.widget.textbox()
line:set_text("|")
space = wibox.widget.textbox()
space:set_text(" ")
----------------------
-- rtar = wibox.widget.textbox()
-- rtar:set_markup("<span color='" .. beautiful.fg_focus .. "'>ƛ</span>")
-- rtar:buttons(awful.util.table.join(awful.button({ }, 1, function () mymainmenu:toggle() end)))
-- ltar = wibox.widget.textbox()
-- ltar:set_markup("<span color='" .. beautiful.fg_focus .. "'> Ɲ</span>")
arrr = wibox.widget.imagebox()
arrr:set_image(icons .. "/arrows/arrr.png")
arrl = wibox.widget.imagebox()
arrl:set_image(icons .. "/arrows/arrl.png")
arr1 = wibox.widget.imagebox()
arr1:set_image(icons .. "/arrows/arr1.png")
arr2 = wibox.widget.imagebox()
arr2:set_image(icons .. "/arrows/arr2.png")
arr3 = wibox.widget.imagebox()
arr3:set_image(icons .. "/arrows/arr3.png")
arr4 = wibox.widget.imagebox()
arr4:set_image(icons .. "/arrows/arr4.png")
arr5 = wibox.widget.imagebox()
arr5:set_image(icons .. "/arrows/arr5.png")
arr6 = wibox.widget.imagebox()
arr6:set_image(icons .. "/arrows/arr6.png")
arr7 = wibox.widget.imagebox()
arr7:set_image(icons .. "/arrows/arr7.png")
arr8 = wibox.widget.imagebox()
arr8:set_image(icons .. "/arrows/arr8.png")
arr9 = wibox.widget.imagebox()
arr9:set_image(icons .. "/arrows/arr9.png")
arr10 = wibox.widget.imagebox()
arr10:set_image(icons .. "/arrows/arr10.png")
arr11 = wibox.widget.imagebox()
arr11:set_image(icons .. "/arrows/arr11.png")
arr12 = wibox.widget.imagebox()
arr12:set_image(icons .. "/arrows/arr12.png")
arr13 = wibox.widget.imagebox()
arr13:set_image(icons .. "/arrows/arr13.png")
arr14 = wibox.widget.imagebox()
arr14:set_image(icons .. "/arrows/arr14.png")
arr15 = wibox.widget.imagebox()
arr15:set_image(icons .. "/arrows/arr15.png")
arr16 = wibox.widget.imagebox()
arr16:set_image(icons .. "/arrows/arr16.png")
-- }}}
