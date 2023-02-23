love = require("love")

function love.load()
	player = {
		x = 20,
		y = 20
	}
end

function love.update()
	if love.keyboard.isDown("a") then
		player.x = player.x - 2
	end

	if love.keyboard.isDown("d") then
		player.x = player.x + 2
	end
end

function love.draw()
	love.graphics.circle("fill", player.x, player.y, 20)
end
