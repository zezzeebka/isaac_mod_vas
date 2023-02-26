local mod = RegisterMod("My Mod", 1)
local airmax = Isaac.GetItemIdByName("Airmax")
local airmaxSpeed = 0.5

function mod:EvaluateCache(player, cacheFlags)
    if cacheFlags & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
        local itemCount = player:GetCollectibleNum(airmax)
        local speedToAdd = airmaxSpeed * itemCount
        player.MoveSpeed = player.MoveSpeed + speedToAdd
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)
