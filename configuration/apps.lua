local filesystem = require('gears.filesystem')

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) .. ' -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = 'xfce4-terminal',
    office = 'libreoffice',
    mail = 'thunderbird',  
    rofi = rofi_command,
    lock = 'i3lock-fancy',
    quake = 'xfce4-terminal',
    screenshot = 'flameshot screen -p ~/Imagens',
    region_screenshot = 'flameshot gui',
    delayed_screenshot = 'flameshot screen -p ~/Imagens -d 5000',
    browser = 'brave',
    editor = 'code', -- gui text editor
    social = 'discord',
    game = 'scid',
    files = 'nemo',
    music = 'com.spotify.Client' 
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    'picom --config ' .. filesystem.get_configuration_dir() .. '/configuration/picom.conf',
    'nitrogen --restore &',
    'nm-applet --indicator', -- wifi
    'pnmixer', -- shows an audiocontrol applet in systray when installed.
    --'blueberry-tray', -- Bluetooth tray icon
    'numlockx on', -- enable numlock
    'pamac-tray', -- starts pamac tray
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    --'xfce4-power-manager', -- Power manager
    -- 'flameshot',
    -- 'synology-drive -minimized',
    -- qq 'steam -silent',
    -- 'feh --randomize --bg-fill ~/.wallpapers/*',
    --'/usr/bin/variety',
    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    '~/.config/awesome/configuration/awspawn' -- Spawn "dirty" apps that can linger between sessions
  }
}
