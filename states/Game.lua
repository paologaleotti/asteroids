local Asteroid = require("objects.Asteroid")

function Game()
    local asteroids = {}

    local set_state = function(self, state)
        self.state.menu = state == "menu"
        self.state.paused = state == "paused"
        self.state.running = state == "running"
        self.state.endend = state == "ended"
    end

    local start_new_game = function(self, player)
        self:set_state("running")
        table.insert(asteroids, Asteroid(100, 100, 100, self.level))
    end

    return {
        state = {
            menu = false,
            paused = false,
            running = true,
            ended = false
        },
        level = 1,
        asteroids = asteroids,
        set_state = set_state,
        start_new_game = start_new_game
    }
end

return Game
