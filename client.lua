-- Config --
local detonateRadius = 175

-- Customs Shop Locations --
local customsShops = {
    {Pos = vector3(-335.5, -134.08, 39.51), Dist = 21.0},
    {Pos = vector3(-1154.54, -2009.08, 13.18), Dist = 21.0},
    {Pos = vector3(1179.18, 2639.21, 39.35), Dist = 12.0},
    {Pos = vector3(106.11, 6624.48, 33.36), Dist = 12.0},
    {Pos = vector3(-208.78, -1325.7, 30.89), Dist = 15.0},
}

local getPlayerPed = GetPlayerPed(-1)
local playerVehicle = GetVehiclePedIsUsing(getPlayerPed)
local isPedInVehicle = IsPedInVehicle(getPlayerPed, playerVehicle, 0)

-- Place Vehicle Bomb --
RegisterCommand('placecarbomb', function()

    local getPlayerPed = GetPlayerPed(-1)
    local playerVehicle = GetVehiclePedIsUsing(getPlayerPed)
    local isPedInVehicle = IsPedInVehicle(getPlayerPed, playerVehicle, 0)
    local playerLoc = GetEntityCoords(getPlayerPed)

    local inCustomsShop = false
    
    for k, v in pairs(customsShops) do
        if #(playerLoc - v.Pos) < v.Dist then
            inCustomsShop = true
        end
    end

    if isPedInVehicle == 1 and inCustomsShop then
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
    local doesCurrentCarHaveBomb = HasVehiclePhoneExplosiveDevice(playerVehicle)
    local isPedInVehicle = IsPedInVehicle(getPlayerPed, playerVehicle, 0)
    local playerLoc = GetEntityCoords(getPlayerPed)

    local inCustomsShop = false
    
    for k, v in pairs(customsShops) do
        if #(playerLoc - v.Pos) < v.Dist then
            inCustomsShop = true
        end
    end
    
    if doesCurrentCarHaveBomb == 1 and inCustomsShop then
        ClearVehiclePhoneExplosiveDevice(playerVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb is removed.", type = "success", timeout = (10000), layout = "bottomCenter",})
    else
        exports.pNotify:SendNotification({text = "You are not inside of a Customs Shop with a vehicle that has a bomb.", type = "error", timeout = (10000), layout = "bottomCenter",})
    end
end)

-- Detonate Car Bomb --
local detonate = RegisterCommand('detonatecarbomb', function()

    local getPlayerPed = GetPlayerPed(-1)
    local playerLastVehicle = GetVehiclePedIsIn(getPlayerPed, 1)
    local doesCarHaveBomb = HasVehiclePhoneExplosiveDevice(playerLastVehicle)
    local playerLoc = GetEntityCoords(getPlayerPed)
    local vehiclePos = GetEntityCoords(playerLastVehicle)
    local vehAndPedDist = GetDistanceBetweenCoords(vehiclePos.x, vehiclePos.y, vehiclePos.z, playerLoc.x, playerLoc.y, playerLoc.z) < detonateRadius
    local getStreetHash = GetStreetNameAtCoord(vehiclePos.x, vehiclePos.y, vehiclePos.z)
    local getStreetName = GetStreetNameFromHashKey(getStreetHash)
    
    if doesCarHaveBomb == 1 and vehAndPedDist then
        DetonateVehiclePhoneExplosiveDevice(playerLastVehicle)
        exports.pNotify:SendNotification({text = "Your car bomb has exploded on "..getStreetName..".", type = "success", timeout = (10000), layout = "bottomCenter",})
    elseif doesCarHaveBomb == 1 and not vehAndPedDist then
        exports.pNotify:SendNotification({text = "You are too far away from the vehicle, which is located at "..getStreetName..".", type = "error", timeout = (10000), layout = "bottomCenter",})
    else
        exports.pNotify:SendNotification({text = "The vehicle doesn't have a car bomb.", type = "error", timeout = (10000), layout = "bottomCenter",})
    end
end)
