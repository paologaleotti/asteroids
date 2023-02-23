local engine = require("love")
local Thruster = require("objects.Thruster")

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
        speed = 3,
    }

    local assert_thrusting = function(self, fps, friction)
        if self.thrusting then
            self.thrust.x = self.thrust.x + self.thrust.speed * math.cos(self.angle) / fps
            self.thrust.y = self.thrust.y - self.thrust.speed * math.sin(self.angle) / fps
        else
            if self.thrust.x ~= 0 or self.thrust.y ~= 0 then
                self.thrust.x = self.thrust.x - friction * self.thrust.x / fps
                self.thrust.y = self.thrust.y - friction * self.thrust.y / fps
            end
        end
    end

    local assert_edge_teleport = function(self)
        if self.x + self.radius < 0 then
            self.x = engine.graphics.getWidth() + self.radius
        elseif self.x - self.radius > engine.graphics.getWidth() then
            self.x = 0 - self.radius
        end

        if self.y + self.radius < 0 then
            self.y = engine.graphics.getHeight() + self.radius
        elseif self.y - self.radius > engine.graphics.getHeight() then
            self.y = 0 - self.radius
        end
    end

    local draw = function(self)
        local opacity = 1

        if self.thrusting then
            self.thruster:draw(self.x, self.y, self.angle, self.radius)
        end

        engine.graphics.setColor(1, 1, 1, opacity)
        engine.graphics.polygon(
            "line",
            calculate_player_vertices(self.x, self.y, self.angle, self.radius)
        )
    end

    local move = function(self)
        local fps = love.timer.getFPS()
        local friction = 0.7

        self.rotation = 360 / 180 * math.pi / fps

        if engine.keyboard.isDown("a") then
            self.angle = self.angle + self.rotation
        end

        if engine.keyboard.isDown("d") then
            self.angle = self.angle - self.rotation
        end

        assert_thrusting(self, fps, friction)
        assert_edge_teleport(self)

        self.x = self.x + self.thrust.x
        self.y = self.y + self.thrust.y
    end

    return {
        x = spawn_x,
        y = spawn_y,
        radius = SHIP_SIZE / 2,
        angle = VIEW_ANGLE,
        rotation = 0,
        thrusting = false,
        thrust = thrust,
        thruster = Thruster(),
        draw = draw,
        move = move
    }
end

return Player
