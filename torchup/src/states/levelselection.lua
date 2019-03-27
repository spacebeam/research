levelselection = {}

local lg = love.graphics

function levelselection.enter()
	state = STATE_LEVELSELECTION
	level = 1
	--playMusic("menujazz")
end

function levelselection.update(dt)
	updateKeys()
end

function levelselection.draw()
	lg.push()
	lg.scale(config.scale)
	lg.print("PLEASE SELECT", 129, 11)
	lg.print("A LEVEL", 151, 22)
	lg.draw(img.level_buildings, quad.level_buildings, 116, 34)
	drawBox(6,82,126,69)
	drawBox(6,44,126,38)
	if level == 1 then
		lg.draw(img.level_buildings, quad.building_outline1, 138,121)
	elseif level == 2 then
		lg.draw(img.level_buildings, quad.building_outline2, 192,108)
	else
		lg.draw(img.level_buildings, quad.building_outline3, 156,43)
	end
	lg.printf(BUILDING_NAMES[level][1], 16, 54, 107, "center")
	lg.printf(BUILDING_NAMES[level][2], 16, 66, 107, "center")
	lg.print(DIFFICULTY_NAMES[level], 16, 92)
	if level == 1 then	
		lg.print("FLOORS: " .. 1, 16, 106)
	elseif level == 2 then
		lg.print("FLOORS: " .. 2, 16, 106)
	else
		lg.print("FLOORS: " .. 3, 16, 106)
	end
	lg.print("MISSES: "..string.rep("@",6-level), 16, 120)
	if highscores[level][1] then
		lg.print("BEST: "..highscores[level][1].score, 16, 134)
	else
		lg.print("BEST:", 16, 134)
	end
	lg.pop()
end

function levelselection.keypressed(k, uni)
	if k == "right" or k == "down" then
		level = level + 1
		if level > 3 then level = 1 end
	elseif k == "left" or k == "up" then
		level = level - 1
		if level < 1 then level = 3 end
	elseif k == "return" or k == " " then
		ingame.enter(level)
	elseif k == "escape" then
		mainmenu.enter()
	end
end

function levelselection.action(k)
	if k == "right" or k == "down" then
		level = level + 1
		if level > 3 then level = 1 end
	elseif k == "left" or k == "up" then
		level = level - 1
		if level < 1 then level = 3 end
	elseif k == "jump" or k == "pause" then
		ingame.enter(level)
	elseif k == "action" then
		mainmenu.enter()
	end
end