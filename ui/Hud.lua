local helper = require("common.helper")
local Text = require("ui.Text")

local draw_text = function(label, value, text_y)
    Text(
        label .. value,
        10,
        text_y,
        "p",
        helper.screen_width,
        "left",
        1
    ):draw()
end

local function Hud(player, game)
    local draw = function(self)
        draw_text("Lives: ", player.lives, 10)
        draw_text("Level: ", game.level, 30)
        draw_text("Score: ", game.score, 50)
    end

    return {
        draw = draw
    }
end

return Hud
