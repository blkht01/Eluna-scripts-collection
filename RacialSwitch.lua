local npcid = 1432 -- npc ID
local Cost = 500000 -- 50 Gold its in coppar


-- This is the traits / Racials
local T = {
    [1] = {"Human", 1, {20598, 20597, 58985, 20864, 59752, 20599}}, -- Human
    [2] = {"Orc", 2, {33702, 20573, 65222, 20572, 20574}}, -- Orc
    [3] = {"Dwarf", 3, {2481, 20596, 59224, 20594}}, -- Dwarf
    [4] = {"Night Elf", 4, {21009, 20583, 20582, 58984, 20585}}, -- Night Elf
    [5] = {"Undread", 5, {20577, 20579, 5227, 7744}}, -- Undread
    [6] = {"Tauren", 6, {20552, 20550, 20551, 20549}}, -- Tauren
    [7] = {"Gnome", 7, {20592, 20593, 20589, 20591}}, -- Gnome
    [8] = {"Troll", 8, {20557, 26297, 26290, 58943, 20555, 20558}}, -- Troll
    [9] = {"Blood Elf", 9, {28877, 822, 25046, 28730, 50613}}, -- Blood Elf
    [10] = {"Draenei", 10, {59542, 28875, 6562, 59221}} -- Draenei
}

local function OnHelloRacialSwitch(event, player, creature)
    if player:IsInCombat() then
        player:SendBroadcastMessage("You are in combat!")
        player:GossipComplete()
    else
        for i, v in ipairs(T) do
            player:GossipMenuAddItem(0, v[1], i, 0)
        end
        player:GossipSendMenu(1, creature)
    end
end
--This will unlearn all the racials from the char once the person select other one. Could probably been done better.
local unlearn = {
    20598,
    20597,
    58985,
    20864,
    59752,
    20599,
    33702,
    20573,
    65222,
    20572,
    20574,
    2481,
    20596,
    59224,
    20594,
    21009,
    20583,
    20582,
    58984,
    20585,
    20577,
    20579,
    5227,
    7744,
    20552,
    20550,
    20551,
    20549,
    20592,
    20593,
    20589,
    20591,
    20557,
    26297,
    26290,
    58943,
    20555,
    20558,
    28877,
    822,
    25046,
    28730,
    50613,
    59542,
    28875,
    6562,
    59221
}
local function OnGossipRacialSwitch(event, player, creature, sender, intid, code, menu_id)
    if (sender == 0) then
        OnHelloRacialSwitch(event, player, creature)
        return
    end
    if (intid == 0) then
        for i, v in ipairs(T[sender]) do
            if (i > 2) then
                player:GossipMenuAddItem(3, "Racial", sender, i, nil, "Are you sure?", Cost)
            end
        end
        player:GossipMenuAddItem(0, "Back", 0, 0)
        player:GossipSendMenu(1, creature)
        return
    else
        for _, v in ipairs(unlearn) do
            player:RemoveSpell(v)
        end

        for _, v in ipairs(T[sender][intid]) do
            player:LearnSpell(v)
        end
    end

    player:GossipComplete()
end

RegisterCreatureGossipEvent(npcid, 1, OnHelloRacialSwitch)
RegisterCreatureGossipEvent(npcid, 2, OnGossipRacialSwitch)
