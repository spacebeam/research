local sti = require("./lib/sti/sti")
local bump = require("./lib/bump/bump")

local gamestate = require("./lib/hump/gamestate")


local loveframes = require("loveframes")

local menu = require("./src/states/menu")
local intro = require("./src/states/intro")
local game = require("./src/states/game")

--local beholder

local paused = false
local pauseNextFrame = false
local pauseCanvas = nil

-- Scale world
local scale = 2.5

local world = {}

local player = {
    x = 50,
    y = 50,
    lastY = 50,
    w = 6.5,
    h = 6.5,
    speed = 90
}

-- set rescaling filter
love.graphics.setDefaultFilter("nearest", "nearest")

love.mouse.setVisible(false)



function love.load()
    gamestate.registerEvents()
	gamestate.switch(menu)
end

function gamekeypressed(key)
    if key == "escape" then 
        love.event.quit()
    end
end

function love.keypressed(key)
    gamekeypressed(key)
    --loveframes.keypressed(key, unicode)
end

--function love.update(dt)
    --loveframes.update(dt)
--end
                 
--function love.draw()
    --loveframes.draw()
--end

--function love.keyreleased(key)
    --loveframes.keyreleased(key)
--end

--function love.mousepressed(x, y, button)
    --loveframes.mousepressed(x, y, button)
--end

--function love.mousereleased(x, y, button)
    --loveframes.mousereleased(x, y, button)
--end