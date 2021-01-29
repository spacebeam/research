local sti = require("./lib/sti/sti")
local bump = require("./lib/bump/bump")

local game = {}

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

-- replace gfx with a better cursor!
local cursor = love.graphics.newImage("assets/gfx/hand.png")

function game:enter()
    -- setup luerl entities here

    --Entities.clear()
    world = bump.newWorld(32)

    -- Load tiled map file
    map = sti("/assets/maps/Overwatch.lua", {'bump'})
    map:bump_init(world)
    -- Create new dynamic data layer called "Sprites" as the 3th layer
    local layer = map:addCustomLayer("Sprites", 3)
    -- Get spawn object
    local spawn
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            spawn = object
            break
        end
    end
    -- Create player object
    layer.player = {
        x      = spawn.x,
        y      = spawn.y
    }
    player["x"] = layer.player.x
    player["y"] = layer.player.y
    world:add(player, player.x, player.y, player.w, player.h)
    -- Remove unneeded object layer
    map:removeLayer("entities")
end

function game:update(dt)
    --Entities.update(dt)
    -- Update world
    map:update(dt)
    local cols, len = 0, 0
    player.lastY = player.y
    -- update the player.x and player.y when arrow keys are pressed
    if love.keyboard.isDown("w", "up") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("s", "down") then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown("a", "left") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("d", "right") then
        player.x = player.x + player.speed * dt
    end
    -- update the player associated bounding box in the world
    player.x, player.y, cols, len = world:move(player, player.x, player.y)
end

function game:draw()
    local screen_width  = love.graphics.getWidth()  / scale
    local screen_height = love.graphics.getHeight() / scale
    local dx = math.floor(player.x - screen_width  / 2)
    local dy = math.floor(player.y - screen_height / 2)
    love.graphics.scale(scale)
    love.graphics.translate(-dx, -dy)
    -- Draw world
    map:draw(-dx, -dy, scale, scale)
    love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
    -- Draw mouse cursor
    love.graphics.draw(cursor, love.mouse.getX() - cursor:getWidth() / 2, love.mouse.getY() - cursor:getHeight() / 2)
end

return game