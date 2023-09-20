local swordRange = 30  -- Change this to your desired range

-- Usernames to Whitelist (Doesn't work with othes)
local whitelist = {
    "iiStaryxz",
    "lilSavage_2233",
    -- Add more usernames here
}

-- Calculate the distance between the two Vector3 positions
local function getDistance(position1, position2)
    return (position1 - position2).Magnitude
end

-- Check Whitelist
local function isPlayerWhitelisted(player)
    local playerName = player.Name
    for _, username in pairs(whitelist) do
        if playerName == username then
            return true
        end
    end
    return false
end

-- Main loop to continuously check for nearby players
while true do
    -- Get the LocalPlayer and their position
    local playerService = game:GetService("Players")
    local localPlayer = playerService.LocalPlayer
    local localPlayerCharacter = localPlayer.Character

    -- Check for Sword (Loop)
    local sword = localPlayerCharacter:FindFirstChild("Sword")
    if sword then
        local localPlayerPosition = localPlayerCharacter.HumanoidRootPart.Position

        -- Iterate through all players in the game
        for _, player in pairs(playerService:GetPlayers()) do
            -- Check if the player is not the LocalPlayer
            if player ~= localPlayer then
                -- Check if the player has a valid character
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local playerPosition = player.Character.HumanoidRootPart.Position
                    local distance = getDistance(localPlayerPosition, playerPosition)

                    -- Check player range and whitelist
                    if distance <= swordRange and not isPlayerWhitelisted(player) then
                        -- Hit Event
                        game:GetService("Players").LocalPlayer.Character.Sword.HitEvent:FireServer(player.Character) -- Pass TC
                    end
                end
            end
        end
    end

    
    wait(0.1)  -- Totally Necessary Delay
end
