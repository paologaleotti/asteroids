local engine = require("love")
local helper = require("common.helper")

local Button = require "ui.Button"

local function Menu(game, player)
    local buttons = {
        Button(
            nil,
            nil,
            nil,
            helper.screen_width / 3,
            50,
            "New Game",
            "h3",
            helper.screen_width / 3,
            helper.screen_height * 0.25
        )
    }

    local draw = function(self)
        for _, button in pairs(buttons) do
            button:draw()
        end
    end

    return {
        draw = draw
    }
end

return Menu
