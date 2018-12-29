mainmenu = {}

local MENU_STRINGS = {
	"IVY.NONSENSE", "HOW TO PLAY", "OPTIONS"
}

lg = love.graphics

function mainmenu.enter()
	state = STATE_MAINMENU
	selection = 1
end

function mainmenu.update(dt)
	updateKeys()
end

function mainmenu.draw()
	lg.push()
	lg.scale(config.scale)
	lg.draw(img.splash, quad.screen, 0,0)
	lg.setFont(font.bold)
	for i=1,3 do
		if i == selection then
			lg.print(">", 144, 86+i*13)
		end
		lg.print(MENU_STRINGS[i], 152, 86+i*13)
	end
	lg.pop()
end

function mainmenu.keypressed(k, uni)
	if k == "down" then
		selection = wrap(selection + 1, 1,3)
	elseif k == "up" then
		selection = wrap(selection - 1, 1,3)
	elseif k == "return" or k == " " then
		if selection == 1 then
			levelselection.enter()
		elseif selection == 2 then
			howto.enter()
		elseif selection == 3 then
			options.enter()
		end
	elseif k == "escape" then
		love.event.quit()
	end
end

function mainmenu.action(k)
	if k == "down" then
		selection = wrap(selection + 1, 1,3)
	elseif k == "up" then
		selection = wrap(selection - 1, 1,3)
	elseif k == "jump" then
		if selection == 1 then
			levelselection.enter()
		elseif selection == 2 then
			howto.enter()
		elseif selection == 3 then
			options.enter()
		end
	end
end
