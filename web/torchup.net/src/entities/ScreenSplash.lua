local class = require("./lib/middleclass/middleclass")
local assets = require("src/assets") 

local ScreenSplash = class('ScreenSplash')

function ScreenSplash:drawHud()
   love.graphics.setFont(assets.fnt_hud)
   local align = self.align
   local w, h = love.graphics.getWidth() * self.pos.x, love.graphics.getHeight() * self.pos.y
   local dx, dy = self.offset.x, self.offset.y
   if align == "center" then
       dx = dx - self.splash.width / 2
   end
   if align == "right" then
       dx = dx - self.splash.width
   end
   love.graphics.printf(self.splash.text, w + dx, h + dy, self.splash.width, self.align)
end

function ScreenSplash:initialize(x, y, text, width, fnt, align, xo, yo)
    self.pos = {x = x, y = y} 
    self.offset = {x = xo or 0, y = yo or 0}
    self.hudBg = true
    self.align = align or "center"
    self.splash = {
        text = text,
        fnt = fnt,
        width = width or 400
    }
end

return ScreenSplash
