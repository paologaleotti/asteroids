local engine = require("love")

local function calculate_flame_vertices(x, y, angle, radius, flame)
    return x - radius * (2 / 3 * math.cos(angle) + 0.5 * math.sin(angle)),
        y + radius * (2 / 3 * math.sin(angle) - 0.5 * math.cos(angle)),
        x - radius * flame * math.cos(angle),
        y + radius * flame * math.sin(angle),
        x - radius * (2 / 3 * math.cos(angle) - 0.5 * math.sin(angle)),
        y + radius * (2 / 3 * math.sin(angle) + 0.5 * math.cos(angle))
end

local function Thruster()
    local draw = function(self, x, y, angle, radius)
        engine.graphics.setColor(1, 102 / 25, 25 / 255)
        engine.graphics.polygon(
            "fill",
            calculate_flame_vertices(x, y, angle, radius, self.flame)
        )
    end

    return {
        flame = 2.0,
        draw = draw
    }
end

return Thruster
