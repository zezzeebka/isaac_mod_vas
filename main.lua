local mod = RegisterMod("My Mod", 1)
local airmax = Isaac.GetItemIdByName("Airmax")
local maksakov = Isaac.GetItemIdByName("Maksakov's Hat")
local airmaxSpeed = 0.5


function mod:CacheUpdate(player, cacheFlag)
    local player = Isaac.GetPlayer(0)
    if player:HasCollectible(maksakov) then
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
            player.Damage = player.Damage + 0.5;
            player:AddMaxHearts(-2, true);
        end
        if cacheFlag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay - 1;
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck - 1;
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

