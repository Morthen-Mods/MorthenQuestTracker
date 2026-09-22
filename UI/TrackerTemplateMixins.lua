-- MQT_HeaderTemplate inherits ListHeaderVisualTemplate (Blizzard_SharedXML/ListTemplates.xml),
-- which already provides SetHeaderText(text), GetCollapseButton() and the hover highlight; this
-- mixin only adds the click-to-toggle behaviour on top.
MQT_HeaderMixin = {}

function MQT_HeaderMixin:OnLoad()
    self:GetCollapseButton():UpdateCollapsedState(true)
end

--- Called by the scrollbox tree view's element factory with the header's tree node.
function MQT_HeaderMixin:Init(treeNode)
    self.treeNode = treeNode
    self:SetHeaderText(treeNode:GetData().name)
    self:GetCollapseButton():UpdateCollapsedState(treeNode:IsCollapsed())
end

--- Toggles the tree node's collapsed state, which hides/shows its child entry
--- rows and reflows the scrollbox.
function MQT_HeaderMixin:OnClick()
    local isCollapsed = self.treeNode:ToggleCollapsed(TreeDataProviderConstants.RetainChildCollapse, TreeDataProviderConstants.DoInvalidation)
    self:GetCollapseButton():UpdateCollapsedState(isCollapsed)
end

MQT_EntryMixin = {}

function MQT_EntryMixin:SetData(entry)
    self.Text:SetText(entry.text)
    self:SetChecked(entry.checked)
end

function MQT_EntryMixin:SetChecked(checked)
    self.checked = checked
    self.Check:SetTexture(checked and "Interface\\Buttons\\UI-CheckBox-Check" or nil)
end

-- MQT_ModeTabButtonTemplate inherits LargeSideTabButtonTemplate, the same
-- generic side-tab widget CharacterFrame uses for CharacterFrameModeTab1-6
-- (Blizzard_SharedXML/SharedUIPanelTemplates.xml, mixin SidePanelTabButtonMixin).
-- It only needs an icon texture and a click handler; the tab art, selected
-- highlight and tooltip (from the `tooltipText` KeyValue) are handled by the
-- base mixin already.
MQT_ModeTabButtonMixin = CreateFromMixins(SidePanelTabButtonMixin)

function MQT_ModeTabButtonMixin:OnLoad()
    SidePanelTabButtonMixin.OnLoad(self)
    self.Icon:SetTexture(self.iconTexture)
    self:SetCustomOnMouseUpHandler(function(tab, button, upInside)
        if button == "LeftButton" and upInside then
            self:GetParent():SelectModeTab(tab)
        end
    end)
end
