local sti = require("./lib/sti/sti")
local bump = require("./lib/bump/bump")

-- Scale world
local scale = 2

local player = {
    x = 50,
    y = 50,
    lastY = 50,
    w = 8,
    h = 8,
    speed = 90
}

local world = bump.newWorld(32)

function love.load()
    -- Load tiled map file
    map = sti("maps/WindSpirit.lua", {'bump'})
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
    -- map:removeLayer("entities")
end

function gamekeypressed(key)
    if key == "escape" then 
        love.event.quit()
    end
end

function love.keypressed(key)
    gamekeypressed(key)
end

function love.update(dt)
    -- Update world
    map:update(dt)

    player.lastY = player.y

    -- update the player.x and player.y when arrow keys are pressed

    -- Move player up
    if love.keyboard.isDown("w", "up") then
        player.y = player.y - player.speed * dt
    end

    -- Move player down
    if love.keyboard.isDown("s", "down") then
        player.y = player.y + player.speed * dt
    end

    -- Move player left
    if love.keyboard.isDown("a", "left") then
        player.x = player.x - player.speed * dt
    end

    -- Move player right
    if love.keyboard.isDown("d", "right") then
        player.x = player.x + player.speed * dt
    end

    -- update the player associated bounding box in the world
	local newX, newY, cols, len = world:move(player, player.x, player.y)
	player.x, player.y = newX, newY
end

function love.draw()
    local screen_width  = love.graphics.getWidth()  / scale
    local screen_height = love.graphics.getHeight() / scale

    local dx = math.floor(player.x - screen_width  / 2)
    local dy = math.floor(player.y - screen_height / 2)

    love.graphics.scale(scale)
    love.graphics.translate(-dx, -dy)

    -- Draw world
    map:draw(-dx, -dy, scale, scale)

    love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
    
    --map:bump_draw(world, -dx, -dy, scale, scale)
end