local mod = RegisterMod("My Mod", 1)
local airmax = Isaac.GetItemIdByName("Airmax")
local maksakov = Isaac.GetItemIdByName("Maksakov's Hat")
local arqaID = Isaac.GetItemIdByName("ARQA")
local corvus = Isaac.GetItemIdByName("Corvus")
local odens = Isaac.GetItemIdByName("Odens")

local airmaxSpeed = 0.5
local arqaSoulHeartsFlag = 0;

local odensFD = -1
local odensSpeed = 0.2
local odensLuck = 1

local corvusRange = 60;
local corvusDMG = 0.5;
local corvusSS = 0.25;

local arqaFD = -1.5

local maksakovDMG = 0.5
local maksakovFD = -0.7
local maksakovLuck = -1

function mod:SnuserCheck(player)
    if (player:HasCollectible(odens) and player:HasCollectible(corvus) and player:HasCollectible(arqaID)) then
        player.Damage = player.Damage + 1;
    end

end


function mod:onUpdate()
    
    if Game():GetFrameCount() == 1 then
        mod.HasArqa = false
        mod.HasCorvus = false
        mod.HasOdens = false
        mod.HasMaksakov = false
    end

    for playerNum = 1, Game():GetNumPlayers() do
        local player1 = Game():GetPlayer(playerNum)
        if player1:HasCollectible(arqaID) then
            if not mod.HasArqa == true then
                player1:AddSoulHearts(2)
                mod.HasArqa = true
            end
        end
        if player1:HasCollectible(corvus) then
            if not mod.HasCorvus == true then
                player1:AddMaxHearts(-2, true)
                mod.HasCorvus = true
            end
        end
        if player1:HasCollectible(odens) then
            if not mod.HasOdens == true then
                player1:AddEternalHearts(1)
                mod.HasOdens = true
            end
        end
        if player1:HasCollectible(maksakov) then
           if not mod.HasMaksakov == true then
                player1:AddMaxHearts(-2, true)
                mod.HasMaksakov = true
           end 
        end

    end
end


--airmax
function mod:EvaluateCache(player, cacheFlags)
    local airmaxCount = player:GetCollectibleNum(airmax, true)
    local odensCount = player:GetCollectibleNum(odens, true)
    local corvusCount = player:GetCollectibleNum(corvus, true)
    local arqaCount = player:GetCollectibleNum(arqaID, true)
    local maksakovCount = player:GetCollectibleNum(maksakov, true)







    if cacheFlags & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then


        local speedToAdd = airmaxSpeed * airmaxCount + odensCount * odensSpeed
        player.MoveSpeed = player.MoveSpeed + speedToAdd
    end
    if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then

        local DamageToAdd = corvusDMG * corvusCount + maksakovDMG * maksakovCount
        if odensCount == 1 then
            if corvusCount == 1 then
                if arqaCount == 1 then
                    DamageToAdd = DamageToAdd + 1
                end
            end
        end


        player.Damage = player.Damage + DamageToAdd
    end
    if cacheFlags & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then

        local RangeToAdd = corvusRange * corvusCount
        player.TearRange = player.TearRange + RangeToAdd
    end
    if cacheFlags & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
        local FDToAdd = odensFD * odensCount + arqaFD * arqaCount + maksakovCount * maksakovFD
        player.MaxFireDelay = player.MaxFireDelay + FDToAdd
    end
    if cacheFlags & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
        local LuckToAdd = odensCount * odensLuck + maksakovLuck * maksakovCount
        player.Luck = player.Luck + LuckToAdd;
    end
    if cacheFlags & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
        local SSToAdd = corvusCount * corvusSS
        player.ShotSpeed = player.ShotSpeed + SSToAdd
    end
end

function mod:onRender()
    local player = Isaac.GetPlayer()
    local odensCount = player:GetCollectibleNum(odens, true)
    local corvusCount = player:GetCollectibleNum(corvus, true)
    local arqaCount = player:GetCollectibleNum(arqaID, true)
    Isaac.RenderText(tostring(corvusCount), 50, 30, 1, 1, 1, 255)
    Isaac.RenderText(tostring(arqaCount), 100, 30, 1, 1, 1, 255)
    Isaac.RenderText(tostring(odensCount), 150, 30, 1, 1, 1, 255)
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.onRender)



mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onUpdate)

