local engine = require("love")
local helper = require("common.helper")

local function Laser(x, y, angle)
    local SHOOT_SPEED = 500
    local BULLET_SIZE = 3
    local EXPLODE_DURATION = 0.5

    local draw = function(self)
        if self.explosion < 1 then
            engine.graphics.setColor(1, 1, 1)
            engine.graphics.setPointSize(BULLET_SIZE)
            engine.graphics.points(self.x, self.y)
        else
            engine.graphics.setColor(1, 104 / 255, 0)
            engine.graphics.circle("fill", self.x, self.y, 7 * 1.5)

            engine.graphics.setColor(1, 234 / 255, 0)
            engine.graphics.circle("fill", self.x, self.y, 7)
        end
    end

    local move = function(self, dt)
        local x_velocity = SHOOT_SPEED * math.cos(angle) * dt
        local y_velocity = -SHOOT_SPEED * math.sin(angle) * dt

        if self.explode_time > 0 then
            self.explosion = 1
        end

        self.x = self.x + x_velocity
        self.y = self.y + y_velocity
        self.distance = self.distance + math.sqrt(
                (x_velocity ^ 2) + (y_velocity ^ 2)
            )
        helper.process_edge_position(self)
    end

    local explode = function(self, dt)
        self.explode_time = math.ceil(EXPLODE_DURATION * dt)

        if self.explode_time > EXPLODE_DURATION then
            self.explosion = 2
        end
    end


    return {
        x = x,
        y = y,
        distance = 0,
        explosion = 0,
        explode_time = 0,
        draw = draw,
        move = move,
        explode = explode
    }
end

return Laser
