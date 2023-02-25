local engine = require("love")

local function Laser(x, y, angle)
    local SHOOT_SPEED = 500
    local BULLET_SIZE = 3

    local process_edge_position = function(self)
        if self.x < 0 then
            self.x = engine.graphics.getWidth()
        elseif self.x > engine.graphics.getWidth() then
            self.x = 0
        end

        if self.y < 0 then
            self.y = engine.graphics.getHeight()
        elseif self.y > engine.graphics.getHeight() then
            self.y = 0
        end
    end

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
        process_edge_position(self)
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
