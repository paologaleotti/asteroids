local engine = require("love")
local Player = require("Player")



function engine.load()
	local center_x, center_y = engine.graphics.getWidth() / 2, engine.graphics.getHeight() / 2
	engine.mouse.setVisible(false)

	player = Player(center_x, center_y)
end

function engine.update()
end

function engine.draw()
	player:draw()
end
