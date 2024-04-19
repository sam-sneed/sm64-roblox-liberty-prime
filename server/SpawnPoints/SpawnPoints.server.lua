-- Function to move the player's character to a random spawn location of the same team color
local function movePlayerToTeamSpawn(player)
    local teamColor = player.TeamColor
    local spawnLocations = game.Workspace:FindPartsInRegion3(nil, game.Workspace.Map.SpawnRegions:GetChildren()) -- Assuming SpawnRegions are separate parts
    local teamSpawn = nil
    
    -- Find a spawn location with the same TeamColor as the player's team
    for _, spawn in pairs(spawnLocations) do
        if spawn.TeamColor == teamColor then
            teamSpawn = spawn
            break
        end
    end
    
    if teamSpawn then
        player.Character:SetPrimaryPartCFrame(CFrame.new(teamSpawn.Position))
    else
        warn("No spawn location found for team color: " .. tostring(teamColor))
    end
end

-- Connect the function to player respawning
game.Players.PlayerAdded:Connect(function(player)
    player.RespawnLocation = nil -- Make sure player has no pre-defined respawn location
    
    player.CharacterAdded:Connect(function(character)
        -- Move player to team spawn on character added (respawn)
        movePlayerToTeamSpawn(player)
    end)
end)
