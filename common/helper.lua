local engine = require("love")

local screen_width = engine.graphics.getWidth()
local screen_height = engine.graphics.getHeight()

local function calculate_distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

local function process_edge_position(object)
    local radius = object.radius or 0

    if object.x + radius < 0 then
        object.x = screen_width + radius
    elseif object.x - radius > screen_width then
        object.x = 0 - radius
    end

    if object.y + radius < 0 then
        object.y = screen_height + radius
    elseif object.y - radius > screen_height then
        object.y = 0 - radius
    end
end

return {
    screen_height = screen_height,
    screen_width = screen_width,
    calculate_distance = calculate_distance,
    process_edge_position = process_edge_position
}
