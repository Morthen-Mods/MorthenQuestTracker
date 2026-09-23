local addonName, MQT = ...

MQT_MainFrameMixin = {}

function MQT_MainFrameMixin:OnLoad()
    self:SetTitle("Morthen Quest Tracker")
    ButtonFrameTemplate_HidePortrait(self)

    self:SelectModeTab(self.Tabs[1])
end

function MQT_MainFrameMixin:SelectModeTab(selectedTab)
    for _, tab in ipairs(self.Tabs) do
        tab:SetChecked(tab == selectedTab)
    end

    -- TODO: Change/Update Content logic
end