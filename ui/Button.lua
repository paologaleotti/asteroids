local engine = require("love")
local Text = require("ui.Text")

local function Button(callback, text_color, button_color, width, height, text, font_size, button_x, button_y)
    callback = callback or function() print("no callback attached") end

    local btn_text = {
        x = width / 2,
        y = height / 2
    }
    local default_color = { r = 1, g = 1, b = 1 }

    local draw = function(self)
        engine.graphics.setColor(self.button_color.r, self.button_color.g, self.button_color.b)
        engine.graphics.rectangle("fill", self.button_x, self.button_y, self.width, self.height)

        engine.graphics.setColor(self.text_color.r, self.text_color.g, self.text_color.b)
        self.text_object:draw()
    end

    return {
        text_color = text_color or default_color,
        button_color = button_color or default_color,
        width = width or 100,
        height = height or 60,
        text = text or "",
        button_x = button_x or 0,
        button_y = button_y or 0,
        text_object = Text(text, btn_text.x, btn_text.y, font_size, width, "center"),
        draw = draw
    }
end

return Button
