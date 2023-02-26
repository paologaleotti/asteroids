local engine = require("love")
local helper = require("common.helper")

function Text(text, x, y, font_size, wrap_width, align, opacity)
    font_size = font_size or "p"
    wrap_width = wrap_width or helper.screen_width
    align = align or "left"
    opacity = opacity or 1

    local fonts = {
        h1 = love.graphics.newFont(60),
        h2 = love.graphics.newFont(50),
        h3 = love.graphics.newFont(40),
        p = love.graphics.newFont(16),
    }

    local set_color = function(self, r, g, b)
        self.colors.r = r
        self.colors.g = g
        self.colors.b = b
    end

    local draw = function(self, tbl_text, index)
        engine.graphics.setColor(self.colors.r, self.colors.g, self.colors.b)
        engine.graphics.setFont(fonts[font_size])
        engine.graphics.printf(self.text, self.x, self.y, wrap_width, align)
    end

    return {
        x = x,
        y = y,
        text = text,
        opacity = opacity,
        set_color = set_color,
        draw = draw,
        colors = {
            r = 1,
            g = 1,
            b = 1
        }
    }
end

return Text
