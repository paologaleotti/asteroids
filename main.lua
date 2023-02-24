local engine = require("love")

local Player = require("objects.Player")
local Game = require("states.Game")
local Overlay = require("ui.Overlay")

math.randomseed(os.time())

function engine.load()
	local center_x, center_y = engine.graphics.getWidth() / 2, engine.graphics.getHeight() / 2
	engine.mouse.setVisible(false)

	_G.player = Player(center_x, center_y)
	_G.game = Game()
	_G.paused_overlay = Overlay("Paused")

	game:start_new_game(player)
end

function engine.keypressed(key)
	if key == "escape" then
		if game.state.running then
			game:set_state("paused")
		elseif game.state.paused then
			game:set_state("running")
		end
	end
end

function engine.update()
	if game.state.running then
		player:move()
	end
end

function engine.draw()
	if game.state.paused then
		paused_overlay:draw()
	end

	player:draw()

	for _, asteroid in pairs(game.asteroids) do
		asteroid:draw()
	end
end
