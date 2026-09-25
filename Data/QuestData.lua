local _, MQT = ...

MQT.QuestDB = {}

MQT.QuestDataFields = {
    level        = 1,  -- number, -1 = scales with player level
    minLevel     = 2,  -- number
    areaID       = 3,  -- zone ID, or negative = category (class/profession/event)
    reward       = 4,  -- { exp, money, items = {}, choiceItems = {}, reputation = { {faction, amount} } }
    preQuestAll  = 5,  -- number[]  all required
    preQuestAny  = 6,  -- number[]  one is enough
    exclusiveTo  = 7,  -- number[]  taking/completing one of these blocks this quest
    races        = 8,  -- string[]  race tokens from UnitRace (e.g. "NightElf", "Scourge"), nil = all
    classes      = 9,  -- string[]  class tokens from UnitClass (e.g. "WARRIOR"), nil = all
    reputation   = 10, -- { faction, min?, max? }  requirement
    skill        = 11, -- { skillID, minValue }
    starts       = 12, -- { npc = {}, object = {}, item = {} }
    questFlags   = 13, -- bitmask, Questie/cmangos format (8 = sharable)
    specialFlags = 14, -- bitmask, see MQT.QuestSpecialFlags
    event        = 15, -- eventID or nil
}

-- specialFlags values as used by Questie
MQT.QuestSpecialFlags = {
    REPEATABLE    = 1,
    NEEDS_EVENT   = 2,
    MONTHLY_RESET = 4, -- requires REPEATABLE
}

---@param questID number
function MQT.QuestDB.GetQuestData(questID)
    return MQT.QuestData[questID]
end

function MQT.QuestDB.GetQuestField(questID, field)
    if type(field) ~= "number" or field < 1 or field > 15 then return end

    local questData = MQT.QuestData[questID]
    if not questData then return end

    return questData[field]
end

-- MQT.QuestData is generated into Data/QuestList.lua
