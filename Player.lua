local engine = require("love")

local function calculate_player_vertices(x, y, angle, radius)
    return x + ((4 / 3) * radius) * math.cos(angle),
        y - ((4 / 3) * radius) * math.sin(angle),
        x - radius * (2 / 3 * math.cos(angle) + math.sin(angle)),
        y + radius * (2 / 3 * math.sin(angle) - math.cos(angle)),
        x - radius * (2 / 3 * math.cos(angle) - math.sin(angle)),
        y + radius * (2 / 3 * math.sin(angle) + math.cos(angle))
end

local function Player(spawn_x, spawn_y)
    local SHIP_SIZE = 30
    local VIEW_ANGLE = math.rad(90)

    local thrust = {
        x = 0,
        y = 0,
        speed = 0
    }

    local draw = function(self)
        local opacity = 1
        engine.graphics.setColor(1, 1, 1, opacity)
        engine.graphics.polygon(
            "line",
            calculate_player_vertices(self.x, self.y, self.angle, self.radius)
        )
    end

    local move = function(self)
        local fps = love.timer.getFPS()
        local friction = 0.7
        print(fps)

        self.rotation = 360 / 180 * math.pi / fps

        if engine.keyboard.isDown("a") then
            self.angle = self.angle + self.rotation
        end

        if engine.keyboard.isDown("d") then
            self.angle = self.angle - self.rotation
        end
    end

    return {
        x = spawn_x,
        y = spawn_y,
        radius = SHIP_SIZE / 2,
        angle = VIEW_ANGLE,
        rotation = 0,
        thrusting = false,
        thrust = thrust,
        draw = draw,
        move = move
    }
end

return Player
