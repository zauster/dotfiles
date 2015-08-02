-- Destoryers

function volclose()
    screen = mouse.screen
    for p,pos in pairs(naughty.notifications[screen]) do
        for i,n in pairs(naughty.notifications[screen][p]) do
			if (n.width == 259) then
            naughty.destroy(n)
            break
            end
        end
    end
end

function genclose()
    screen = mouse.screen
    for p,pos in pairs(naughty.notifications[screen]) do
        for i,n in pairs(naughty.notifications[screen][p]) do
			if (n.width == 157) then
            naughty.destroy(n)
            break
            end
        end
    end
end

-- Global Settings

fg = "#FFFEDD"
bg = "#44444450"
border_color = "#FFE88F"

-- Volume Notify

volnotiicon = nil
function volnoti()
			        volclose()
                                naughty.notify{
				icon = volnotiicon,
				icon_height = 48,
				timeout = 1,
				width = 259,
				margin = 2,
				padding = 2,
				gap = 0,
				border_width = 	0,
				position = "bottom_right"
			}
end

-- Batery Notify

function batnoti()
			        genclose()
                                naughty.notify{
                                title="Battery\n",
                                text=awful.util.pread("/home/mtrokic/.config/awesome/scripts/battery"),
				timeout = 4,
				width = 155,
				height = 98,
				margin = 6,
				padding = 2,
				spacing = 2,
				gap = 0,
				border_width = 	1,
				position = "bottom_right"
			}
end

-- Chromiums Notify

function chromiumsnoti()
			        genclose()
                                naughty.notify{
                                title="Encryption\n",
                                text="Socks Chromium",
				timeout = 4,
				width = 155,
				height = 64,
				margin = 6,
				padding = 2,
				spacing = 2,
				gap = 0,
				border_width = 	1,
				position = "bottom_right"
			}
end
