require("windows")
HYPER = {"cmd", "alt", "ctrl"}
hs.hotkey.bind(HYPER, "W", function()
    hs.notify.new({title = "Hammerspoon", informativeText = "Hello World"}):send()
end)

-- ~~~~~~~~~~~~~~~~~~~~~ CONFIG RELOAD ~~~~~~~~~~~~~~~~~~~~~
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function() hs.reload() end)
hs.notify.new({title = "Hammerspoon", informativeText = "Config Reloaded"}):send()
