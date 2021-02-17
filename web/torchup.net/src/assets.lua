local multisource = require("./lib/multisource/multisource")

local assets = {}

love.graphics.setDefaultFilter("nearest", "nearest")


assets.img_cat = love.graphics.newImage("assets/gfx/cat.png")

assets.snd_meow = love.audio.newSource("assets/sfx/meow.ogg", "static")
assets.snd_music = love.audio.newSource("assets/sfx/music.ogg", "stream")

assets.fnt_hud = love.graphics.newFont("assets/fonts/DiaryOfAn8BitMage.ttf", 48)
assets.fnt_smallhud = love.graphics.newFont("assets/fonts/ps2px.ttf", 32)
assets.fnt_reallysmallhud = love.graphics.newFont("assets/fonts/ThinPixel7.ttf", 24)


return assets
