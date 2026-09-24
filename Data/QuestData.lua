local _, MQT = ...

---@class MQT_QuestInfo
---@field level         number -- if -1 the quest scales with the player level
---@field minLevel      number
---@field areaID        number
---@field reward        MQT_QuestReward
---@field preQuests     number[]
---@field race?         number
---@field class?        number
---@field profession?   number
---@field skill?        number
---@field reputation?   number
---@field startNpc?     number
---@field startItem?    number

---@class MQT_QuestReward
---@field exp number
---@field items? number[]
---@field money? number

MQT.QuestData = {

}