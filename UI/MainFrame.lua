local addonName, addon = ...

MQT_MainFrameMixin = {}

function MQT_MainFrameMixin:OnLoad()
    self:SetTitle("Morthen Quest Tracker")
    ButtonFrameTemplate_HidePortrait(self)
end

local f = CreateFrame("Frame", addonName .. "MainFrame", UIParent, "MQT_MainFrameTemplate")