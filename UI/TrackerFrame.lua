local addonName, MQT = ...

MQT.UI = MQT.UI or {}

local PADDING = 16
local HEADER_HEIGHT = 22
local ROW_HEIGHT = 16
local GROUP_SPACING = 6
local FRAME_WIDTH = 250

function MQT.UI.Layout()
    local y = -PADDING

    for _, group in ipairs(MQT.UI.groups) do
        local header = group.header
        header:ClearAllPoints()
        header:SetPoint("TOPLEFT", MQT.UI.trackerFrame, "TOPLEFT", PADDING, y)
        header:SetPoint("TOPRIGHT", MQT.UI.trackerFrame, "TOPRIGHT", -PADDING, y)
        y = y - HEADER_HEIGHT

        for _, row in ipairs(group.rows) do
            if header.collapsed then
                row:Hide()
            else
                row:Show()
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", MQT.UI.trackerFrame, "TOPLEFT", PADDING, y)
                row:SetPoint("TOPRIGHT", MQT.UI.trackerFrame, "TOPRIGHT", -PADDING, y)
                y = y - ROW_HEIGHT
            end
        end

        y = y - GROUP_SPACING
    end

    MQT.UI.trackerFrame:SetHeight(-y + PADDING)
end

local function CreateTrackerFrame()
    local frame = CreateFrame("Frame", "MorthenQuestTrackerFrame", UIParent, "BasicFrameTemplate")
    frame:SetWidth(FRAME_WIDTH)
    frame:SetPoint("CENTER", UIParent, "CENTER")

    return frame
end

MQT.UI.trackerFrame = CreateTrackerFrame()
MQT.UI.groups = {}
MQT.UI.groupsByName = {}

--- Creates a new entry row (MQT_EntryTemplate) for entryData = { text = "...", checked = true/false }.
function MQT.UI:CreateEntryRow(entryData)
    local row = CreateFrame("Frame", nil, self.trackerFrame, "MQT_EntryTemplate")
    row:SetData(entryData)
    return row
end

--- Creates a new collapsible group (MQT_HeaderTemplate + its entry rows) and adds it to the tracker.
--- entries is optional: a list of { text = "...", checked = true/false }.
--- Returns the group handle, which can be passed straight into MQT.UI:AddEntry.
function MQT.UI:AddGroup(name, entries)
    local header = CreateFrame("Button", nil, self.trackerFrame, "MQT_HeaderTemplate")
    header:SetHeaderText(name)
    header.OnCollapsedChanged = function()
        self.Layout()
    end

    local group = {
        name = name,
        header = header,
        rows = {},
    }

    table.insert(self.groups, group)
    self.groupsByName[name] = group

    for _, entryData in ipairs(entries or {}) do
        table.insert(group.rows, self:CreateEntryRow(entryData))
    end

    self.Layout()
    return group
end

--- Adds a single entry row to an existing group. `group` can be the group
--- handle returned by AddGroup, or the group's name.
--- entryData: { text = "...", checked = true/false }
function MQT.UI:AddEntry(group, entryData)
    if type(group) == "string" then
        group = self.groupsByName[group]
    end
    assert(group, "MQT.UI:AddEntry - unknown group")

    table.insert(group.rows, self:CreateEntryRow(entryData))
    self.Layout()
end

for _, groupData in ipairs(MQT.Data) do
    MQT.UI:AddGroup(groupData.name, groupData.entries)
end
