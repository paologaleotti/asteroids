local Asteroid = require("objects.Asteroid")

function Game()
    local asteroids = {}

    local set_state = function(self, state)
        self.state.menu = state == "menu"
        self.state.paused = state == "paused"
        self.state.running = state == "running"
        self.state.endend = state == "ended"
    end

    local increase_score = function(self, modifier)
        self.score = math.ceil(self.score + 10 * self.level / 2 * modifier / 2)
    end

    local start_new_game = function(self, player)
        self:set_state("running")
        table.insert(asteroids, Asteroid(300, 300, 100, self.level))
    end

    return {
        state = {
            menu = false,
            paused = false,
            running = true,
            ended = false
        },
        level = 1,
        score = 0,
        asteroids = asteroids,
        set_state = set_state,
        increase_score = increase_score,
        start_new_game = start_new_game
    }
end

return Game
