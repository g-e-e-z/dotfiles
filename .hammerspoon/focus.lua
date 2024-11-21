hyperShortcuts = {
    {"1", "Alacritty"}, {"2", "Google Chrome"}, {"3", "Postman"}, {"4", "Slack"}
}

function launchOrFocusOrHide(appName)
    local frontApp = hs.application.frontmostApplication()
    if appName == frontApp:name() then
        frontApp:hide()
    else
        hs.application.launchOrFocus(appName)
    end

end

for _, shortcut in ipairs(hyperShortcuts) do
    hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, shortcut[1],
                   function() launchOrFocusOrHide(shortcut[2]) end)
end
