-- Config --
local detonateRadius = 175

-- Place Vehicle Bomb --
RegisterCommand('placecarbomb', function()

    local getPlayerPed = GetPlayerPed(-1)
    local playerVehicle = GetVehiclePedIsUsing(getPlayerPed)
    local isPedInVehicle = IsPedInVehicle(getPlayerPed, playerVehicle, 0)
    local playerLoc = GetEntityCoords(getPlayerPed)

    if isPedInVehicle == 1 and GetDistanceBetweenCoords(1179.18, 2639.21, 39.35, playerLoc.x, playerLoc.y, playerLoc.z) < 12 then
        AddVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "You have placed a car bomb.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif isPedInVehicle == 1 and GetDistanceBetweenCoords(106.11, 6624.48, 33.36, playerLoc.x, playerLoc.y, playerLoc.z) < 12 then
        AddVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "You have placed a car bomb.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif isPedInVehicle == 1 and GetDistanceBetweenCoords(-335.5, -134.08, 39.51, playerLoc.x, playerLoc.y, playerLoc.z) < 21 then
        AddVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "You have placed a car bomb.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif isPedInVehicle == 1 and GetDistanceBetweenCoords(-208.78, -1325.7, 30.89, playerLoc.x, playerLoc.y, playerLoc.z) < 15 then
        AddVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "You have placed a car bomb.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif isPedInVehicle == 1 and GetDistanceBetweenCoords(-1154.54, -2009.08, 13.18, playerLoc.x, playerLoc.y, playerLoc.z) < 21 then
        AddVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "You have placed a car bomb.", type = "success", timeout = (10000), layout = "bottomCenter",})
    else
        exports.pNotify:SendNotification({text = "You are not inside of a Customs Shop with a vehicle.", type = "error", timeout = (10000), layout = "bottomCenter",})
    end
end)

-- Remove Vehicle Bomb --
RegisterCommand('removecarbomb', function()

    local getPlayerPed = GetPlayerPed(-1)
    local playerVehicle = GetVehiclePedIsUsing(getPlayerPed) -- get player vehicle
    local playerLastVehicle = GetVehiclePedIsIn(getPlayerPed, 1)
    local doesCurrentCarHaveBomb = HasVehiclePhoneExplosiveDevice(playerVehicle)
    local isPedInVehicle = IsPedInVehicle(getPlayerPed, playerVehicle, 0)
    local playerLoc = GetEntityCoords(getPlayerPed)
    
    if doesCurrentCarHaveBomb == 1 and isPedInVehicle == 1 and GetDistanceBetweenCoords(1179.18, 2639.21, 39.35, playerLoc.x, playerLoc.y, playerLoc.z) < 12 then
        ClearVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb is removed.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif doesCurrentCarHaveBomb == 1 and isPedInVehicle == 1 and GetDistanceBetweenCoords(106.11, 6624.48, 33.36, playerLoc.x, playerLoc.y, playerLoc.z) < 12 then
        ClearVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb is removed.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif doesCurrentCarHaveBomb == 1 and isPedInVehicle == 1 and GetDistanceBetweenCoords(-335.5, -134.08, 39.51, playerLoc.x, playerLoc.y, playerLoc.z) < 12 then
        ClearVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb is removed.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif doesCurrentCarHaveBomb == 1 and isPedInVehicle == 1 and GetDistanceBetweenCoords(-208.78, -1325.7, 30.89, playerLoc.x, playerLoc.y, playerLoc.z) < 12 then
        ClearVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb is removed.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif doesCurrentCarHaveBomb == 1 and isPedInVehicle == 1 and GetDistanceBetweenCoords(-1154.54, -2009.08, 13.18, playerLoc.x, playerLoc.y, playerLoc.z) < 12 then
        ClearVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb is removed.", type = "success", timeout = (10000), layout = "bottomCenter",})
    else
        exports.pNotify:SendNotification({text = "You are not inside of a Customs Shop with a vehicle that has a bomb.", type = "error", timeout = (10000), layout = "bottomCenter",})
    end
end)

-- Detonate Car Bomb --
RegisterCommand('detonatecarbomb', function()

    local getPlayerPed = GetPlayerPed(-1)
    local playerVehicle = GetVehiclePedIsUsing(getPlayerPed) -- get player vehicle
    local playerLastVehicle = GetVehiclePedIsIn(getPlayerPed, 1)
    local doesCarHaveBomb = HasVehiclePhoneExplosiveDevice(playerLastVehicle)
    local playerLoc = GetEntityCoords(getPlayerPed)
    local vehiclePos = GetEntityCoords(playerLastVehicle)
    
    if doesCarHaveBomb == 1 and GetDistanceBetweenCoords(vehiclePos.x, vehiclePos.y, vehiclePos.z, playerLoc.x, playerLoc.y, playerLoc.z) < detonateRadius then
        DetonateVehiclePhoneExplosiveDevice(playerLastVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb has exploded.", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif doesCarHaveBomb == 1 and GetDistanceBetweenCoords(vehiclePos.x, vehiclePos.y, vehiclePos.z, playerLoc.x, playerLoc.y, playerLoc.z) > detonateRadius then
        exports.pNotify:SendNotification({text = "You are too far away from the vehicle.", type = "error", timeout = (10000), layout = "bottomCenter",})
    else
        exports.pNotify:SendNotification({text = "The vehicle doesn't have a car bomb.", type = "error", timeout = (10000), layout = "bottomCenter",})
    end
end)
