local values = {
    healthBar = 100,
    armorBar = 100,
    foodBar = 100,
    drinkBar = 100,
    staminaBar = 100,
    job = "Valmi nem tölt be! - Pandateam"
}

local hudVisible = true
local forcehudVisible = true
local lastStamina = nil

RegisterCommand("hud", function()
    hudVisible = not hudVisible
    SendNUIMessage({ type = "toggleHud", state = hudVisible })
end, false)

AddEventHandler("esx_status:onTick", function(data)
    local hunger, thirst
    for i = 1, #data do
        if data[i].name == "thirst" then
            thirst = math.floor(data[i].percent)
        end
        if data[i].name == "hunger" then
            hunger = math.floor(data[i].percent)
        end
    end
    local invOpen = LocalPlayer.state.invOpen
    local playerPed = PlayerPedId()
    values.healthBar = math.floor((GetEntityHealth(playerPed) - 100) / 100 * 100)
    values.armorBar = GetPedArmour(playerPed)
    values.drinkBar = thirst
    values.foodBar = hunger
    values.staminaBar = GetPlayerStamina(PlayerId())
    values.job = ESX.PlayerData.job.label.. " - ".. ESX.PlayerData.job.grade_label

    if values.staminaBar == 100 and lastStamina ~= 100 then
        lastStamina = 100
    elseif values.staminaBar ~= 100 then
        lastStamina = nil
    end
    if IsPauseMenuActive() or invOpen then
        forcehudVisible = false
        SendNUIMessage({ type = "toggleHud", state = forcehudVisible })
    else
        if not hudVisible then return end
            forcehudVisible = true
        SendNUIMessage({ type = "toggleHud", state = forcehudVisible })
    end
    SendNUIMessage({
        type = 'updateHud',
        health = values.healthBar,
        armor = values.armorBar > 0 and values.armorBar or false,
        hunger = values.foodBar,
        thirst = values.drinkBar,
        stamina = lastStamina == 100 and nil or values.staminaBar,
        job = values.job,
        mic = MumbleIsPlayerTalking(PlayerId())
    })
end)


AddEventHandler('esx:playerLoaded', function (xPlayer, skin)
    values.job = xPlayer.job.label.. " - ".. xPlayer.job.grade_label
    SendNUIMessage({
        type = 'updateHud',
        job = values.job
    })
end)

RegisterNetEvent("esx:setJob") 
AddEventHandler('esx:setJob', function(job,lastJob)
    values.job = job.label.. " - ".. job.grade_label
    SendNUIMessage({
        type = 'updateHud',
        job = values.job
    })
end)
