require("windows")
require("focus")

-- ~~~~~~~~~~~~~~~~~~~~~ CONFIG RELOAD ~~~~~~~~~~~~~~~~~~~~~
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.notify.new({title = "Hammerspoon", informativeText = "Config Reloaded"}):send()
-- voice = hs.speech.new("Zarvox")
-- voice:speak("why hello there, obi wan.")
