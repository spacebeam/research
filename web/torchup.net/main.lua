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
    speed = 80,
    dx = 0,
    dy = 0
}

local world = bump.newWorld(128)

function love.load()
    -- Load tiled map file
    map = sti("maps/Overwatch.lua", {'bump'})
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
    map:removeLayer("Object Layer 1")
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


    local speed = player.speed

    player.lastY = player.y

    local dx, dy = 0, 0

    -- Move player up
    if love.keyboard.isDown("w", "up") then
        dy = -speed * dt
    end

    -- Move player down
    if love.keyboard.isDown("s", "down") then
        dy = speed * dt
    end

    -- Move player left
    if love.keyboard.isDown("a", "left") then
        dx = -speed * dt
    end

    -- Move player right
    if love.keyboard.isDown("d", "right") then
        dx = speed * dt
    end


    -- get the collisions
    local tx, ty, cols, len = world:check(player, dx, dy)

    -- If there where no collisions, we can move the player safely
    if len == 0 then
        player.x, player.y = dx, dy
        world:move(player, player.x, player.y)
    else

        print('tomela ' .. #cols)

    end
end

function love.draw()
    local screen_width  = love.graphics.getWidth()  / scale
    local screen_height = love.graphics.getHeight() / scale


    local dx = math.floor(player.x - screen_width  / 2)
    local dy = math.floor(player.y - screen_height / 2)

    -- Draw world
    map:draw(-dx, -dy, scale, scale)

    love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)

    map:bump_draw(world, -dx, -dy, scale, scale)
end