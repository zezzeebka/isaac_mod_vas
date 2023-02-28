local mod = RegisterMod("My Mod", 1)
local airmax = Isaac.GetItemIdByName("Airmax")
local maksakov = Isaac.GetItemIdByName("Maksakov's Hat")
local arqa = Isaac.GetItemIdByName("ARQA")
local corvus = Isaac.GetItemIdByName("Corvus")
local odens = Isaac.GetItemIdByName("Odens")
local airmaxSpeed = 0.5
local arqaSoulHeartsFlag = 0;

function mod:SnuserCheck(player)
    if (player:HasCollectible(odens) and player:HasCollectible(corvus) and player:HasCollectible(arqa)) then
        player.Damage = player.Damage + 1;
    end

end

function mod:onUpdate()
    if Game():GetFrameCount() == 1 then
        mod.HasArqa = false
        mod.HasCorvus = false
        mod.HasOdens = false
    end
    for playerNum = 1, Game():GetNumPlayers() do
        local player1 = Game():GetPlayer(playerNum)
        if player1:HasCollectible(arqa) then
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
    end
end

function mod:CacheUpdate(player, cacheFlag)
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(maksakov) then
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + 0.5;
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay - 1;
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck - 1;
        end
    end

    if player:HasCollectible(arqa) then
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay - 1.5;
                arqaSoulHeartsFlag = 1;

        end
    end

    if player:HasCollectible(corvus) then
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + 0.5;
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearRange = player.TearRange + 60;
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + 0.25;
        end
    end

    if player:HasCollectible(odens) then
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay - 1;
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + 0.2;
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + 1;
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.CacheUpdate)


function mod:EvaluateCache(player, cacheFlags)
    if cacheFlags & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
        local itemCount = player:GetCollectibleNum(airmax)
        local speedToAdd = airmaxSpeed * itemCount
        player.MoveSpeed = player.MoveSpeed + speedToAdd
    end

end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onUpdate)

