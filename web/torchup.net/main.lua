-- Include Simple Tiled Implementation into project
local sti = require "./lib/sti/sti"

function love.load()
	-- Load map file
	map = sti("maps/WindSpirit.lua")

	-- Create new dynamic data layer called "Sprites" as the 8th layer
	local layer = map:addCustomLayer("Sprites", 3)

	-- Get player spawn object
	local player
	for k, object in pairs(map.objects) do
		if object.name == "Player" then
			player = object
			break
		end
	end

	-- Create player object
	local sprite = love.graphics.newImage("asset/gfx/portrait.png")
	layer.player = {
		sprite = sprite,
		x      = player.x,
		y      = player.y,
		ox     = sprite:getWidth() / 2,
		oy     = sprite:getHeight() / 1.35
	}

	-- Add controls to player
	layer.update = function(self, dt)
		-- 96 pixels per second
		local speed = 96 * dt

		-- Move player up
		if love.keyboard.isDown("w", "up") then
			self.player.y = self.player.y - speed
		end

		-- Move player down
		if love.keyboard.isDown("s", "down") then
			self.player.y = self.player.y + speed
		end

		-- Move player left
		if love.keyboard.isDown("a", "left") then
			self.player.x = self.player.x - speed
		end

		-- Move player right
		if love.keyboard.isDown("d", "right") then
			self.player.x = self.player.x + speed
		end
	end

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

function love.update(dt)
	-- Update world
	map:update(dt)
end

function love.draw()
	-- Scale world
	local scale = 2
	local screen_width  = love.graphics.getWidth()  / scale
	local screen_height = love.graphics.getHeight() / scale

	-- Translate world so that player is always centred
	local player = map.layers["Sprites"].player
	local tx = math.floor(player.x - screen_width  / 2)
	local ty = math.floor(player.y - screen_height / 2)

	-- Transform world
	--love.graphics.scale(scale)
	--love.graphics.translate(-tx, -ty)

	-- Draw world
	map:draw(-tx, -ty, scale, scale)
end