splash = {}

lg = love.graphics

function splash.enter()
	state = STATE_SPLASH
	transition_time = 0
end

function splash.update(dt)
	transition_time = transition_time + dt
end

function splash.draw()
	lg.push()
	lg.scale(config.scale)
	if transition_time < 4 then
		if transition_time < 1 then
			local alpha = cap(255*transition_time, 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print("PRESS START", 150, 140)
			lg.setColor(255,255,255,255)
		elseif transition_time > 3 then
			local alpha = cap(255*(1-(transition_time-3)), 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print("PRESS START", 150, 140)
			lg.setColor(255,255,255,255)
		else
			lg.print("PRESS START", 150, 140)
		end
	elseif transition_time < 8 then
		if transition_time < 5 then
			local alpha = cap(255*(transition_time-4), 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print("PRESS START", 150, 140)
			lg.setColor(255,255,255,255)
		elseif transition_time > 7 then
			local alpha = cap(255*(1-(transition_time-7)), 0,255)
			lg.setColor(255,255,255,alpha)
			lg.print("PRESS START", 150, 140)
			lg.setColor(255,255,255,255)
		else
			lg.print("PRESS START", 150, 140)
		end
	elseif transition_time < 10 then
		local alpha = cap(128*(transition_time-8), 0, 255)
		lg.setColor(255,255,255,alpha)
		lg.draw(img.splash, quad.screen, 0,0)
		lg.setColor(255,255,255,255)
	else
		lg.draw(img.splash, quad.screen, 0,0)
		lg.setFont(font.bold)
		if transition_time % 1.6 < 0.8 then
			lg.print("PRESS START", 150, 140)
		end
	end
	lg.pop()
end

function splash.keypressed(k,uni)
	if k == "return" or k == " " or k == "escape" then
		mainmenu.enter()
	end
end

function splash.action(k)
	mainmenu.enter()
	mainmenu.enter()
end