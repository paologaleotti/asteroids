local engine = require("love")
local helper = require("common.helper")
local globals = require("common.globals")

function Asteroid(x, y, size, level)
    local MAX_VERTICES = 12
    local INDENTATION = 0.4
    local SPEED = math.random(50) + (level * 2) + 15
    local DIRECTION = math.random() < 0.5 and 1 or -1
    local MIN_ASTEROID_SIZE = math.ceil(globals.INITIAL_ASTEROID_SIZE / 8)

    local vertices =
        math.floor(math.random(MAX_VERTICES + 1) + MAX_VERTICES / 2)
    local offset = {}

    for i = 1, vertices + 1 do
        table.insert(offset, math.random() * INDENTATION * 2 + 1 - INDENTATION)
    end

    local get_random_velocity = function()
        return math.random() * SPEED * DIRECTION
    end

    local insert_polygon_point = function(self, points_table, coord, angle, index)
        table.insert(points_table, coord + self.radius * self.offset[index + 1] * angle)
    end

    local check_collision = function(self, object)
        return helper.calculate_distance(object.x, object.y, self.x, self.y) <
            self.radius
    end

    local draw = function(self)
        local points = {}

        for i = 1, self.vertices do
            local angle = self.angle + i * math.pi * 2 / self.vertices
            insert_polygon_point(self, points, self.x, math.cos(angle), i)
            insert_polygon_point(self, points, self.y, math.sin(angle), i)
        end

        engine.graphics.setColor(186 / 255, 189 / 255, 182 / 255, 1)
        engine.graphics.polygon("line", points)
    end

    local move = function(self, dt)
        self.x = self.x + self.x_velocity * dt
        self.y = self.y + self.y_velocity * dt

        helper.process_edge_position(self)
    end

    local destroy = function(self, asteroids_table, index)
        if self.radius > MIN_ASTEROID_SIZE then
            for _ = 1, globals.BROKEN_ASTEROID_PIECES do
                table.insert(
                    asteroids_table,
                    Asteroid(self.x, self.y, self.radius, level)
                )
            end
        end

        table.remove(asteroids_table, index)
    end

    return {
        x = x,
        y = y,
        x_velocity = get_random_velocity(),
        y_velocity = get_random_velocity(),
        vertices = vertices,
        offset = offset,
        angle = math.rad(math.random(math.pi)),
        radius = math.ceil(size / 2),
        check_collision = check_collision,
        draw = draw,
        move = move,
        destroy = destroy
    }
end

return Asteroid
