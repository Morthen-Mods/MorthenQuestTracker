local _, MQT = ...

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