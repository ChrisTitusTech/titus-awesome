local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local function renderClient(client, mode)
  if client.skip_decoration or (client.rendering_mode == mode) then
    return
  end

  client.rendering_mode = mode
  client.floating = false
  client.maximized = false
  client.above = false
  client.below = false
  client.ontop = false
  client.sticky = false
  client.maximized_horizontal = false
  client.maximized_vertical = false

  if client.rendering_mode == 'maximized' then
    client.border_width = 0
    client.shape = function(cr, w, h)
      gears.shape.rectangle(cr, w, h)
    end
  elseif client.rendering_mode == 'tiled' then
    client.border_width = beautiful.border_width
    client.shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, 8)
    end
  end
end

local changesOnScreenCalled = {}

local function changesOnScreen(currentScreen)
  local tagIsMax = currentScreen.selected_tag ~= nil and currentScreen.selected_tag.layout == awful.layout.suit.max
  local clientsToManage = {}

  for _, client in pairs(currentScreen.clients) do
    if not client.skip_decoration and not client.hidden then
      table.insert(clientsToManage, client)
    end
  end

  if (tagIsMax or #clientsToManage == 1) then
    currentScreen.client_mode = 'maximized'
  else
    currentScreen.client_mode = 'tiled'
  end

  for _, client in pairs(clientsToManage) do
    renderClient(client, currentScreen.client_mode)
  end
  changesOnScreenCalled[currentScreen.index] = false
end

function clientCallback(client)
  if not client.skip_decoration and client.screen then
    if not changesOnScreenCalled[client.screen.index] then
      changesOnScreenCalled[client.screen.index] = true
      local screen = client.screen
      gears.timer.delayed_call(
        function()
          changesOnScreen(screen)
        end
      )
    end
  end
end

function tagCallback(tag)
  if tag.screen then
    if not changesOnScreenCalled[tag.screen.index] then
      changesOnScreenCalled[tag.screen.index] = true
      local screen = tag.screen
      gears.timer.delayed_call(
        function()
          changesOnScreen(screen)
        end
      )
    end
  end
end

_G.client.connect_signal('manage', clientCallback)

_G.client.connect_signal('unmanage', clientCallback)

_G.client.connect_signal('property::hidden', clientCallback)

_G.client.connect_signal('property::minimized', clientCallback)

_G.client.connect_signal(
  'property::fullscreen',
  function(c)
    if c.fullscreen then
      renderClient(c, 'maximized')
    else
      clientCallback(c)
    end
  end
)

_G.tag.connect_signal('property::selected', tagCallback)

_G.tag.connect_signal('property::layout', tagCallback)

