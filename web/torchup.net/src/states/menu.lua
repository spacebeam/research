local gamestate = require("./lib/hump/gamestate")

local game = require("./src/states/game")

local menu = {}

-- replace gfx with a better cursor!
local cursor = love.graphics.newImage("assets/gfx/hand.png")

function menu:draw()
    love.graphics.draw(cursor, love.mouse.getX() - cursor:getWidth() / 2, love.mouse.getY() - cursor:getHeight() / 2)    
    love.graphics.print("Press Enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
    if key == 'return' then
        gamestate.switch(game)
    end
end

return menu
