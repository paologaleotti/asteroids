local engine = require("love")
local helper = require("common.helper")

local Player = require("objects.Player")
local Game = require("states.Game")
local Overlay = require("ui.Overlay")

math.randomseed(os.time())

function engine.load()
	local center_x = helper.screen_width / 2
	local center_y = helper.screen_height / 2

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

	if key == "space" then
		player:shoot()
	end
end

local function process_lasers_collision(dt, asteroid, ast_index)
	for _, laser in pairs(player.lasers) do
		if asteroid:check_collision(laser) then
			laser:explode(dt)
			asteroid:destroy(game.asteroids, ast_index)
		end
	end
end

function engine.update(dt)
	if game.state.running then
		player:move(dt)

		for ast_index, asteroid in pairs(game.asteroids) do
			process_lasers_collision(dt, asteroid, ast_index)
			asteroid:move(dt)
		end
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
