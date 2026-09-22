local addonName, addon = ...

MQT_MainFrameMixin = {}

function MQT_MainFrameMixin:OnLoad()
    self:SetTitle("Morthen Quest Tracker")
    ButtonFrameTemplate_HidePortrait(self)

    -- Order matches the tab `id`s (1-4) set in TrackerTemplates.xml.
    self.ContentFrames = {
        self.WorldZonesFrame,
        self.DungeonsFrame,
        self.RaidsFrame,
        self.ClassesAndProfessionsFrame,
    }

    self:SelectModeTab(self.Tabs[1])
end

--- Called by MQT_ModeTabButtonMixin when one of the side tabs is clicked.
function MQT_MainFrameMixin:SelectModeTab(selectedTab)
    for _, tab in ipairs(self.Tabs) do
        tab:SetChecked(tab == selectedTab)
    end
    for index, contentFrame in ipairs(self.ContentFrames) do
        contentFrame:SetShown(index == selectedTab:GetID())
    end
end

local f = CreateFrame("Frame", addonName .. "MainFrame", UIParent, "MQT_MainFrameTemplate")