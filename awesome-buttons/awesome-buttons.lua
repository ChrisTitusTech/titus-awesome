local wibox = require("wibox")
local gears = require("gears")

local buttons = {}

buttons.with_icon = function(args)
    local type = args.type or 'basic'
    local color = args.color or '#D8DEE9'
    local icon = args.icon or 'help-circle'
    local shape = args.shape or 'circle'
    local icon_size = args.icon_size or 20
    local icon_margin = args.icon_margin or 4
    local onclick = args.onclick or function () end

    if icon:sub(1, 1) ~= '/' then
        icon = os.getenv("HOME") .. '/.config/awesome/awesome-buttons/icons/' .. icon .. '.svg'
    end

    local result = wibox.widget{
        {
            {
                image = icon,
                resize = true,
                forced_height = icon_size,
                forced_width = icon_size,
                widget = wibox.widget.imagebox
            },
            margins = icon_margin,
            widget = wibox.container.margin
        },
        bg = '#00000000',
        widget = wibox.container.background
    }

    if type == 'outline' then
        result:set_shape_border_color(color)
        result:set_shape_border_width(1)
    elseif type == 'flat' then
        result:set_bg(color)
    end

    if shape == 'circle' then
        result:set_shape(gears.shape.circle)
    elseif shape == 'rounded_rect' then
        result:set_shape(function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 4) end)
    else
        result:set_shape(gears.shape.rectangle)
    end

    local old_cursor, old_wibox
    result:connect_signal("mouse::enter", function(c)
        if type ~= 'flat' then
            c:set_bg(color)
        end
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand1"
    end)
    result:connect_signal("mouse::leave", function(c)
        if type ~= 'flat' then
            c:set_bg('#00000000')
        end
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    result:connect_signal("button::press", function() onclick() end)

    return result
end


buttons.with_text = function(args)
    local type = args.type or 'basic'
    local text = args.text
    local onclick = args.onclick or function() end
    local color = args.color or '#D8DEE9'
    local text_size = args.text_size or 10

    local result = wibox.widget{
        {
            {
                markup = '<span size="' .. text_size .. '000" foreground="'
                    .. ((type == 'flat') and '#00000000' or color) .. '">' .. text ..'</span>',
                widget = wibox.widget.textbox
            },
            top = 4, bottom = 4, left = 8, right = 8,
            widget = wibox.container.margin
        },
        bg = '#00000000',
        shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 4) end,
        widget = wibox.container.background
    }

    if type == 'outline' then
        result:set_shape_border_color(color)
        result:set_shape_border_width(1)
    elseif type == 'flat' then
        result:set_bg(color)
    end

    local old_cursor, old_wibox
    result:connect_signal("mouse::enter", function(c)
        if type ~= 'flat' then
            c:set_bg("#00000066")
        end
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand1"
    end)
    result:connect_signal("mouse::leave", function(c)
        if type ~= 'flat' then
            c:set_bg('#00000000')
        end
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    result:connect_signal("button::press", function() onclick() end)

    return result
end


buttons.with_icon_and_text = function(args)

    local type = args.type or 'basic'
    local text = args.text
    local icon = args.icon
    local onclick = args.onclick or function() end
    local color = args.color or '#D8DEE9'
    local text_size = args.text_size or 10

    if icon:sub(1, 1) ~= '/' then
        icon = os.getenv("HOME") .. '/.config/awesome/awesome-buttons/icons/' .. icon .. '.svg'
    end


    local result = wibox.widget{
        {
            {
                {
                    image = icon,
                    resize = true,
                    forced_height = 20,
                    widget = wibox.widget.imagebox
                },
                margins = 4,
                widget = wibox.container.margin
            },
            {
                {
                    markup = '<span size="' .. text_size .. '000" foreground="'
                        .. ((type == 'flat') and '#00000000' or color) .. '">' .. text ..'</span>',
                    widget = wibox.widget.textbox
                },
                top = 4, bottom = 4, right = 8,
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal
        },
        bg = '#00000000',
        shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 4) end,
        widget = wibox.container.background
    }

        if type == 'outline' then
            result:set_shape_border_color(color)
            result:set_shape_border_width(1)
        end

        if type == 'flat' then
            result:set_bg(color)
        end

        local old_cursor, old_wibox
        result:connect_signal("mouse::enter", function(c)
            if type ~= 'flat' then
                c:set_bg('#00000044')
            end
            local wb = mouse.current_wibox
            old_cursor, old_wibox = wb.cursor, wb
            wb.cursor = "hand1"
        end)
        result:connect_signal("mouse::leave", function(c)
            if type ~= 'flat' then
                c:set_bg('#00000000')
            end
            if old_wibox then
                old_wibox.cursor = old_cursor
                old_wibox = nil
            end
        end)

        result:connect_signal("button::press", function() onclick() end)

        return result
end


return buttons