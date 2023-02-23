function Game()
    local set_state = function(self, state)
        self.state.menu = state == "menu"
        self.state.paused = state == "paused"
        self.state.running = state == "running"
        self.state.endend = state == "ended"
    end

    return {
        state = {
            menu = false,
            paused = false,
            running = true,
            ended = false
        },
        set_state = set_state
    }
end

return Game
