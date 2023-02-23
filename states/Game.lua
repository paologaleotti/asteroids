function Game()
    local change_state = function(self, state)
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
        change_state = change_state
    }
end

return Game
