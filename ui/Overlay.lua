local engine = require("love")
local Text = require("ui.Text")
local helper = require("common.helper")

local function Overlay(text_value)
    local draw = function(self)
        Text(
            self.text_value,
            0,
            helper.screen_height * 0.4,
            "h1",
            helper.screen_width,
            "center",
            1
        ):draw()
    end

    return {
        text_value = text_value or "",
        draw = draw
    }
end

return Overlay
