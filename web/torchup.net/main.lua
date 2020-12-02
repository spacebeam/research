local sti = require("./lib/sti/sti")
local bump = require("./lib/bump/bump")

local message = ''

local player = {
    x = 50,
    lastY = 50,
    y = 50,
    w = 8,
	h = 8,
	speed = 0.85,
    yAcc = 0,
    xAcc = 0,
    vel = 4,
    dx = 0,
	dy = 0
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
	local sprite = love.graphics.newImage("asset/gfx/portrait.png")

	layer.player = {
		sprite = sprite,
		x      = spawn.x,
		y      = spawn.y,
		ox     = sprite:getWidth() / 2,
		oy     = sprite:getHeight() / 1.35
	}

	player["x"] = layer.player.x
	player["y"] = layer.player.y
	player["ox"] = layer.player.ox
	player["oy"] = layer.player.oy

	world:add(player, player.x, player.y, player.w, player.h)

	-- Draw player
	layer.draw = function(self)
		love.graphics.draw(
			self.player.sprite,
			math.floor(self.player.x),
			math.floor(self.player.y),
			0,
			1,
			1,
			self.player.ox,
			self.player.oy
		)

		-- Temporarily draw a point at our location so we know
		-- that our sprite is offset properly
		love.graphics.setPointSize(5)
		love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
	end

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

	player.lastY = player.y
	player.yAcc = 1
	player.dx = 0

	-- Move player up
	if love.keyboard.isDown("w", "up") then
		player.yAcc = -player.speed
	end

	-- Move player down
	if love.keyboard.isDown("s", "down") then
		player.yAcc = player.speed
	end

	-- Move player left
	if love.keyboard.isDown("a", "left") then
		--player.x = player.x - walk_speed
		player.xAcc = -player.speed
	end

	-- Move player right
	if love.keyboard.isDown("d", "right") then
		--player.x = player.x + walk_speed
		player.xAcc = player.speed
	end

	player.dx = player.xAcc * player.vel
    player.dy = player.yAcc * player.vel

    player.x, player.y, cols, len = world:move(player, player.x + player.dx, player.y + player.dy)

	player.xAcc, player.yAcc = 0, player.yAcc * 0.45
end

function love.draw()
	-- Scale world
	local scale = 2
	local screen_width  = love.graphics.getWidth()  / scale
	local screen_height = love.graphics.getHeight() / scale

	-- Translate world so that player is always centred
	local prayer = map.layers["Sprites"].player
	local tx = math.floor(prayer.x - screen_width  / 2)
	local ty = math.floor(prayer.y - screen_height / 2)

	local dx = math.floor(player.x - screen_width  / 2)
	local dy = math.floor(player.y - screen_height / 2)

	--local dx = player.x - (love.graphics.getWidth() / 2) / scale
	--local dy = player.y - (love.graphics.getHeight() / 2) / scale
	
	map:draw(-dx, -dy, scale, scale)

	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)

	-- Draw world
	--map:draw(-tx, -ty, scale, scale)
end