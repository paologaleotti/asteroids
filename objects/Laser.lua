local engine = require("love")

local function Laser(x, y, angle)
    local SHOOT_SPEED = 500
    local BULLET_SIZE = 3

    local draw = function(self)
        engine.graphics.setColor(1, 1, 1)
        engine.graphics.setPointSize(BULLET_SIZE)
        engine.graphics.points(self.x, self.y)
    end


    return {
        x = x,
        y = y,
        draw = draw
    }
end

return Laser
