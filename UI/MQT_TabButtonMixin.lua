local _, MQT = ...

MQT_TabButtonMixin = CreateFromMixins(SidePanelTabButtonMixin)

local fallbackIcon = "Interface\\Icons\\INV_Misc_Map02"

-- 134155 - Blue Dragon
-- 134157 - Green Dragon
-- 134430 - Green Portal

local TabData = {
    [1] = { label = MQT.lang.worldZoneTab, icon = "Interface\\Icons\\INV_Misc_Map02" },
    [2] = { label = MQT.lang.dungeonTab, icon = 134155 }, --"Interface\\Icons\\Achievement_Dungeon_ClassicDungeonMaster" },
    [3] = { label = MQT.lang.raidTab, icon = 134430 },-- "Interface\\Icons\\Achievement_Boss_Onyxia" },
    [4] = { label = MQT.lang.miscTab, icon = "Interface\\Icons\\INV_Misc_Book_09" },
}

local function empty(string)
    return string == nil and string == ""
end

function MQT_TabButtonMixin:OnLoad()
    SidePanelTabButtonMixin.OnLoad(self)
    local data = TabData[self:GetID()]

    self.tooltipText = empty(data.label) and nil or data.label
    self.Icon:SetTexture(empty(data.icon) and fallbackIcon or data.icon)

    self:SetCustomOnMouseUpHandler(function(tab, button, upInside)
        if button == "LeftButton" and upInside then
            self:GetParent():SelectModeTab(tab)
        end
    end)
end