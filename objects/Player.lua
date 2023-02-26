local engine = require("love")
local helper = require("common.helper")

local Thruster = require("objects.Thruster")
local Laser = require("objects.Laser")

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
    local EXPLODE_DURATION = 3
    local VIEW_ANGLE = math.rad(90)
    local LASER_RANGE = 0.6
    local MAX_LASERS = 10

    local process_thrusting = function(self, dt, friction)
        if self.thrusting then
            self.thrust.x = self.thrust.x + self.thrust.speed * math.cos(self.angle) * dt
            self.thrust.y = self.thrust.y - self.thrust.speed * math.sin(self.angle) * dt
        else
            if self.thrust.x ~= 0 or self.thrust.y ~= 0 then
                self.thrust.x = self.thrust.x - friction * self.thrust.x * dt
                self.thrust.y = self.thrust.y - friction * self.thrust.y * dt
            end
        end
    end

    local explode = function(self, dt)
        self.explode_time = math.ceil(EXPLODE_DURATION / dt)
    end

    local draw = function(self)
        if self.exploding then
            engine.graphics.setColor(1, 0, 0)
            engine.graphics.circle("fill", self.x, self.y, self.radius * 1.5)

            engine.graphics.setColor(1, 158 / 255, 0)
            engine.graphics.circle("fill", self.x, self.y, self.radius)
        else
            if self.thrusting then
                self.thruster:draw(self.x, self.y, self.angle, self.radius)
            end

            engine.graphics.setColor(1, 1, 1)
            engine.graphics.polygon(
                "line",
                calculate_player_vertices(self.x, self.y, self.angle, self.radius)
            )

            for _, laser in pairs(self.lasers) do
                laser:draw()
            end
        end
    end

    local move = function(self, dt)
        self.exploding = self.explode_time > 0
        if self.exploding then return end

        local friction = 0.7
        local screen_width = engine.graphics.getWidth()

        self.rotation = 360 / 180 * math.pi * dt

        if engine.keyboard.isDown("a") then
            self.angle = self.angle + self.rotation
        end

        if engine.keyboard.isDown("d") then
            self.angle = self.angle - self.rotation
        end

        player.thrusting = engine.keyboard.isDown("w")

        process_thrusting(self, dt, friction)
        helper.process_edge_position(self)

        self.x = self.x + self.thrust.x
        self.y = self.y + self.thrust.y

        for index, laser in pairs(self.lasers) do
            if (laser.distance > LASER_RANGE * screen_width) and
                (laser.explosion == 0) then
                self:destroy_laser(index)
            end

            if laser.explosion == 0 then
                laser:move(dt)
            elseif laser.explosion == 2 then
                self:destroy_laser(index)
            end
        end
    end

    local shoot = function(self)
        if #self.lasers >= MAX_LASERS then return end
        table.insert(self.lasers, Laser(self.x, self.y, self.angle))
    end

    local destroy_laser = function(self, index)
        table.remove(self.lasers, index)
    end

    return {
        x = spawn_x,
        y = spawn_y,
        radius = SHIP_SIZE / 2,
        angle = VIEW_ANGLE,
        rotation = 0,
        thrusting = false,
        thrust = {
            x = 0,
            y = 0,
            speed = 3,
        },
        thruster = Thruster(),
        lasers = {},
        explode_time = 0,
        exploding = false,
        draw = draw,
        move = move,
        shoot = shoot,
        destroy_laser = destroy_laser,
        explode = explode
    }
end

return Player
