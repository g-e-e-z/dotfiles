hyperShortcutsWork = {
    {"1", "Alacritty"}, {"2", "Firefox"}, {"3", "Postman"}, {"4", "Slack"}
}
hyperShortcutsHome = {
    {"1", "Alacritty"}, {"2", "Firefox"}, {"3", "Spotify"}, {"4", "Discord"}
}

function launchOrFocusOrHide(appName)
    local frontApp = hs.application.frontmostApplication()
    if appName == frontApp:name() then
        frontApp:hide()
    else
        hs.application.launchOrFocus(appName)
    end

end

machine = hs.host.localizedName()
if machine == "monk" then
    apps = hyperShortcutsHome
else
    apps = hyperShortcutsWork
end

for _, shortcut in ipairs(apps) do
    hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, shortcut[1],
                   function() launchOrFocusOrHide(shortcut[2]) end)
end
