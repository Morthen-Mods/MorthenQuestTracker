local addonName, MQT = ...

local f = CreateFrame("Frame", addonName .. "MainFrame", UIParent, "MQT_MainFrameTemplate")

local pendingQuests = {}

TrackerSettings = TrackerSettings or {}

local questLoader = CreateFrame("Frame")
questLoader:RegisterEvent("QUEST_DATA_LOAD_RESULT")

questLoader:SetScript("OnEvent", function(_, event, questID, success)
    if event ~= "QUEST_DATA_LOAD_RESULT" then return end

    if not success then
        print(("|cffff8000MQT|r: Quest %d konnte nicht geladen werden."):format(questID))
        return
    end

    local title = C_QuestLog.GetTitleForQuestID and C_QuestLog.GetTitleForQuestID(questID)
        or C_QuestLog.GetQuestInfo(questID)
    print(("|cffff8000MQT|r: Quest %d geladen: %s"):format(questID, title or "?"))

    local objectives = C_QuestLog.GetQuestObjectives(questID)
    DevTools_Dump(objectives)
    if objectives then
        for _, objective in ipairs(objectives) do
            print("  - " .. (objective.text or "?"))
        end
    end
end)

SLASH_MQT1 = "/mqt"
SlashCmdList["MQT"] = function(msg)
    local questID = tonumber(msg)
    if not questID then
        print("|cffff8000MQT|r: Verwendung: /mqt <questID>")
        return
    end

    C_QuestLog.RequestLoadQuestByID(questID)
end

-- 93736
-- 94487