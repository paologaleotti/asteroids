local engine = require("love")
local Player = require("Player")



function engine.load()
	local center_x, center_y = engine.graphics.getWidth() / 2, engine.graphics.getHeight() / 2
	engine.mouse.setVisible(false)

	player = Player(center_x, center_y)
end

function engine.keypressed(key)
	if key == "w" then
		player.thrusting = true
	end
end

function engine.keyreleased(key)
	if key == "w" then
		player.thrusting = false
	end
end

function engine.update()
	player:move()
end

function engine.draw()
	player:draw()
end
