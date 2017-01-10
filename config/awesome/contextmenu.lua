
local gears = require("gears")
local awful = require("awful")

local capi = {
   screen = screen,
   tag = tag,
   timer = timer,
   mouse = mouse,
   client = client,
   keygrabber = keygrabber
}



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
