local class = require("./lib/middleclass/middleclass")

local gamestate = require("./lib/hump/gamestate")

local game = require("./src/states/game")

local TimerEvent = require("./src/entities/TimerEvent")

local ScreenSplash = require("./src/entities/ScreenSplash")

local TransitionScreen = require("./src/entities/TransitionScreen")

local assets = require("./src/assets")

local sti = require("./lib/sti/sti")

local camera = require("./lib/hump/camera")

local ControlText = [[
Controls:
Move - WASD
Toggle Fullscreen - \
Toggle Music - M
Pause - P
Escape - Quit
]] 

local intro = {}

-- replace gfx with a better cursor!
local cursor = love.graphics.newImage("assets/gfx/hand.png")

function intro:draw()
    love.graphics.draw(cursor, love.mouse.getX() - cursor:getWidth() / 2, love.mouse.getY() - cursor:getHeight() / 2)    
    love.graphics.print("Press Enter to continue", 10, 10)
end

function intro:keyreleased(key, code)
    if key == 'return' then
        gamestate.switch(game)
    end
end

return intro 
