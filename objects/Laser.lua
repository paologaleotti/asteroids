local engine = require("love")
local helper = require("common.helper")

local function Laser(x, y, angle)
    local SHOOT_SPEED = 500
    local BULLET_SIZE = 3

    local draw = function(self)
        engine.graphics.setColor(1, 1, 1)
        engine.graphics.setPointSize(BULLET_SIZE)
        engine.graphics.points(self.x, self.y)
    end

    local move = function(self, dt)
        local x_velocity = SHOOT_SPEED * math.cos(angle) * dt
        local y_velocity = -SHOOT_SPEED * math.sin(angle) * dt

        self.x = self.x + x_velocity
        self.y = self.y + y_velocity
        self.distance = self.distance + math.sqrt(
                (x_velocity ^ 2) + (y_velocity ^ 2)
            )
        helper.process_edge_position(self)
    end


    return {
        x = x,
        y = y,
        distance = 0,
        draw = draw,
        move = move
    }
end

return Laser
