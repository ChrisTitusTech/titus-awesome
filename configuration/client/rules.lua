local awful = require("awful")
local gears = require("gears")
local client_keys = require("configuration.client.keys")
local client_buttons = require("configuration.client.buttons")

-- Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_keys,
      buttons = client_buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_offscreen,
      floating = false,
      maximized = false,
      above = false,
      below = false,
      ontop = false,
      sticky = false,
      maximized_horizontal = false,
      maximized_vertical = false
    }
  },
  {
    rule_any = {name = {"QuakeTerminal"}},
    properties = {skip_decoration = true}
  },
  -- Titlebars
  {
    rule_any = {class = {"Wicd-client.py", "calendar.google.com"}},
    properties = {
      placement = awful.placement.centered,
      ontop = true,
      floating = true,
      drawBackdrop = true,
      shape = function()
        return function(cr, w, h)
          gears.shape.rounded_rect(cr, w, h, 8)
        end
      end,
      skip_decoration = true
    }
  },
  -- -------- Dialog -----------

  {
    id = "dialog",
    rule_any = {
      class = {
        "File-roller",
        "Nm-connection-editor"
      },
      type = {
        "modal",
        "dialog"
      },
      name = {
        "Open File",
        "Save File",
        "Discord Updater",
        "Steam Guard",
        "Steam Guard - Computer Authorization Required"
      },
      instance = {
        "file_progress",
        "Popup",
        "nm-connection-editor",
        "file-roller",
        "gnome-system-monitor",
        "lxappearance",
        "xfce4-power-manager-settings"
      },
      role = {
        "GtkFileChooserDialog",
        "pop-up"
      }
    },
    properties = {
      titlebars_enabled = true,
      maximized = false,
      floating = true,
      above = true,
      draw_backdrop = true,
      skip_decoration = true,
      hide_titlebars = false,
      round_corners = true,
      placement = awful.placement.centered
    },
    callback = function(c)
      c:move_to_tag(awful.screen.focused().selected_tag)
    end
  }
}
