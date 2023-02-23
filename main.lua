local engine = require("love")

local Player = require("objects.Player")
local Game = require("states.Game")


function engine.load()
	local center_x, center_y = engine.graphics.getWidth() / 2, engine.graphics.getHeight() / 2
	engine.mouse.setVisible(false)

	_G.player = Player(center_x, center_y)
	_G.game = Game()
end

function engine.update()
	if game.state.running then
		player:move()
	end
end

function engine.draw()
	player:draw()
end
