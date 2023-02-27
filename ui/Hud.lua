local Text = require("ui.Text")
local helper = require("common.helper")

local function Hud(player, game)
    local draw = function(self)
        Text(
            "Lives: " .. player.lives,
            10,
            10,
            "p",
            helper.screen_width,
            "left",
            1
        ):draw()
        Text(
            "Level: " .. game.level,
            10,
            30,
            "p",
            helper.screen_width,
            "left",
            1
        ):draw()
    end

    return {
        draw = draw
    }
end

return Hud
