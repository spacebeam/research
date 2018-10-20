joystick = {}

local lg = love.graphics

function joystick.enter()
	state = STATE_JOYSTICK
	joystick.selection = 1
	joystick.waiting = false
end

function joystick.update(dt)
	updateKeys()
end

function joystick.draw()
	lg.push()
	lg.scale(config.scale)
	lg.setFont(font.bold)

	drawBox(40,54,176,95)

	lg.printf("SET JOYSTICK", 0, 39, WIDTH, "center")
	for i=1,4 do
		if joystick.waiting == true and joystick.selection == i then
			lg.setColor(195,52,41)
		end
		lg.print(string.upper(joykeynames[i]), 65, 53+i*13)
		lg.print(config.joykeys[joykeynames[i]], 165, 53+i*13)
		lg.setColor(255,255,255)
	end
	lg.print("DEFAULT", 65, 118)
	lg.print("BACK", 65, 131)

	lg.print(">", 52, 53+joystick.selection*13)

	lg.pop()
end

function joystick.keypressed(k, uni)
	if k == "down" then
		joystick.selection = wrap(joystick.selection + 1, 1, 6)
	elseif k == "up" then
		joystick.selection = wrap(joystick.selection - 1, 1, 6)
	elseif k == "return" then
		if joystick.selection >= 1 and joystick.selection <= 4 then -- Keys
			joystick.waiting = true
		elseif joystick.selection == 5 then -- Default
			defaultJoyKeys()
		elseif joystick.selection == 6 then -- Back
			options.enter()
		end
	elseif k == "escape" then
		if joystick.waiting == true then
			joystick.waiting = false
		else
			options.enter()
		end
	end
end

function joystick.joystickpressed(joy, k)
	if joystick.waiting == false then
		for a, key in pairs(config.joykeys) do
			if k == key then
				gamestates[state].action(a)
			end
		end
	else
		config.joykeys[joykeynames[joystick.selection]] = k
		joystick.waiting = false
	end
end

function joystick.action(k)
	if k == "down" then
		joystick.selection = wrap(joystick.selection + 1, 1, 6)
	elseif k == "up" then
		joystick.selection = wrap(joystick.selection - 1, 1, 6)
	elseif k == "jump" then
		if joystick.selection >= 1 and joystick.selection <= 4 then -- Keys
			joystick.waiting = true
		elseif joystick.selection == 5 then -- DEFAULT
			defaultJoyKeys()
		elseif joystick.selection == 6 then -- BACK
			options.enter()
		end
	elseif k == "action" then
		options.enter()
	end
end