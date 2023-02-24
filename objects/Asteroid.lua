local engine = require("love")

function Asteroid(x, y, size, level)
    local ASTEROID_VERTICES = 10
    local ASTEROID_INDENTATION = 0.4
    local ASTEROID_SPEED = math.random(50) + (level * 2)
    local DIRECTION = math.random() < 0.5 and 1 or -1

    local get_random_velocity = function()
        return math.random() * ASTEROID_SPEED * DIRECTION
    end

    local draw = function(self)
        local points = {
            self.x + self.radius * self.offset
        }

        engine.graphics.setColor(186 / 255, 189 / 255, 182 / 255, 1)
    end

    return {
        x = x,
        y = y,
        x_velocity = get_random_velocity(),
        y_velocity = get_random_velocity(),
        radius = math.ceil(size / 2),
        draw = draw
    }
end

return Asteroid
