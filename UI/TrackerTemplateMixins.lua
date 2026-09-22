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
