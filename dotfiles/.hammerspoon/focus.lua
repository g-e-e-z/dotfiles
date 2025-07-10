local hyperShortcutsWork = {
    {"1", "Alacritty"}, {"2", "Google Chrome"}, {"3", "Postman"}, {"4", "Microsoft Teams"}
}
local hyperShortcutsHome = {
    {"1", "Alacritty"}, {"2", "Google Chrome"}, {"3", "Spotify"}, {"4", "Discord"}
}

function LaunchOrFocusOrHide(appName)
    local frontApp = hs.application.frontmostApplication()
    if appName == frontApp:name() then
        frontApp:hide()
    else
        hs.application.launchOrFocus(appName)
    end

end

if hs.host.localizedName() == "monk" then
    Apps = hyperShortcutsHome
else
    Apps = hyperShortcutsWork
end

for _, shortcut in ipairs(Apps) do
    hs.hotkey.bind({"alt"}, shortcut[1],
                   function() LaunchOrFocusOrHide(shortcut[2]) end)
end
