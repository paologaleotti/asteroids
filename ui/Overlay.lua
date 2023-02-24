local engine = require("love")
local Text = require("ui.Text")

local function Overlay(text_value)
    local draw = function(self)
        Text(
            self.text_value,
            0,
            engine.graphics.getHeight() * 0.4,
            "h1",
            engine.graphics.getWidth(),
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
