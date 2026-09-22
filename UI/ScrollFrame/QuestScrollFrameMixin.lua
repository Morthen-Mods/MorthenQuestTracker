MQT_QuestScrollFrameMixin = {}

-- Category submenus; each becomes a flyout button. SetGridMode with no column
-- count lets Blizzard's own AutoCalculateColumns decide (1 column below 11
-- entries, 2 above that, and so on), so short lists like Raids stay a single
-- column while long ones like Kalimdor wrap into two.
--
-- Also doubles as the dummy quest data source: each zone gets a handful of
-- fake quests until real per-zone quest data is wired up.
local CATEGORIES = {
    {
        name = "Kalimdor",
        zones = {
            "Durotar", "Mulgore", "Teldrassil", "The Barrens", "Darkshore",
            "Ashenvale", "Stonetalon Mountains", "Desolace", "Thousand Needles",
            "Dustwallow Marsh", "Feralas", "Tanaris", "Un'Goro Crater",
            "Azshara", "Felwood", "Winterspring", "Moonglade", "Silithus",
            "Orgrimmar", "Thunder Bluff", "Darnassus",
        },
    },
    {
        name = "Eastern Kingdoms",
        zones = {
            "Elwynn Forest", "Westfall", "Redridge Mountains", "Duskwood",
            "Stranglethorn Vale", "Swamp of Sorrows", "Blasted Lands",
            "Loch Modan", "Wetlands", "Arathi Highlands", "Badlands",
            "Hillsbrad Foothills", "The Hinterlands", "Silverpine Forest",
            "Tirisfal Glades", "Western Plaguelands", "Eastern Plaguelands",
            "Burning Steppes", "Searing Gorge", "Dun Morogh",
            "Stormwind City", "Ironforge", "Undercity",
        },
    },
    {
        name = "Dungeon",
        zones = {
            "Ragefire Chasm", "Wailing Caverns", "The Deadmines",
            "Shadowfang Keep", "Blackfathom Deeps", "The Stockade",
            "Gnomeregan", "Razorfen Kraul", "Scarlet Monastery",
            "Razorfen Downs", "Uldaman", "Zul'Farrak", "Maraudon",
            "Sunken Temple", "Blackrock Depths", "Lower Blackrock Spire",
            "Upper Blackrock Spire", "Dire Maul",
        },
    },
    {
        name = "Raids",
        zones = {
            "Molten Core", "Onyxia's Lair", "Blackwing Lair", "Zul'Gurub",
            "Ruins of Ahn'Qiraj", "Temple of Ahn'Qiraj", "Naxxramas",
        },
    },
    {
        name = "Classes",
        zones = {
            "Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Shaman",
            "Mage", "Warlock", "Druid",
        },
    },
    {
        name = "Professions",
        zones = {
            "Alchemy", "Blacksmithing", "Enchanting", "Engineering",
            "Leatherworking", "Tailoring", "Mining", "Herbalism", "Skinning",
            "Cooking", "First Aid", "Fishing",
        },
    },
}

local EVERYTHING_TEXT = "Everything"

function MQT_QuestScrollFrameMixin:OnLoad()
    local indent, top, bottom, left, right, spacing = 0, 0, 0, 0, 0, 0
    local view = CreateScrollBoxListTreeListView(indent, top, bottom, left, right, spacing)
    view:SetElementFactory(function(factory, treeNode)
        local elementData = treeNode:GetData()
        if elementData.name then
            -- Group header row; its extent comes from MQT_HeaderTemplate's declared Size.
            factory("MQT_HeaderTemplate", function(button, node)
                button:Init(node)
            end)
        else
            -- Quest entry row; its extent comes from MQT_EntryTemplate's declared Size.
            factory("MQT_EntryTemplate", function(button, node)
                button:SetData(node:GetData())
            end)
        end
    end)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.ScrollBox, self.ScrollBar, view)

    -- nil/nil means "no filter" / show every category and zone.
    self.selectedCategory = nil
    self.selectedZone = nil
    self:RefreshDataProvider()
    self:SetupGroupFilterDropdown()
end

-- Test data to exercise scroll + collapse behavior; remove once real quest data is wired up.
function MQT_QuestScrollFrameMixin:RefreshDataProvider()
    local dataProvider = CreateTreeDataProvider()
    local zoneCount = 0
    for _, category in ipairs(CATEGORIES) do
        if self.selectedCategory == nil or self.selectedCategory == category.name then
            for _, zoneName in ipairs(category.zones) do
                if self.selectedZone == nil or self.selectedZone == zoneName then
                    local zoneNode = dataProvider:Insert({ name = zoneName })
                    for entryIndex = 1, 5 do
                        zoneNode:Insert({ text = zoneName .. " Quest " .. entryIndex, checked = (entryIndex % 2 == 0) })
                    end
                    zoneCount = zoneCount + 1
                end
            end
        end
    end

    -- New nodes default to uncollapsed; only auto-expand when a single zone is
    -- on screen (e.g. after picking one from the dropdown), otherwise collapse
    -- everything so the tracker doesn't open with every zone expanded.
    if zoneCount > 1 then
        dataProvider:SetAllCollapsed(true)
    end

    self.ScrollBox:SetDataProvider(dataProvider)
end

-- CreateButton has no built-in selection state (unlike CreateRadio), so there's
-- no dot/checkmark and no automatic dropdown-label sync; both are handled by
-- hand here via OverrideText.
--
-- A submenu button (one that has child entries) keeps its own responder
-- callback: clicking the category label itself fires that callback without
-- needing the flyout to be open, while hovering still opens the flyout for
-- the individual zone entries. See CreateButton in MenuTemplates.lua and
-- MenuElementDescriptionProxyMixin:Pick in Menu.lua.
function MQT_QuestScrollFrameMixin:SetupGroupFilterDropdown()
    local function SelectAll()
        self.selectedCategory = nil
        self.selectedZone = nil
        self:RefreshDataProvider()
        self.Dropdown:OverrideText(EVERYTHING_TEXT)
    end

    local function SelectCategory(categoryName)
        self.selectedCategory = categoryName
        self.selectedZone = nil
        self:RefreshDataProvider()
        self.Dropdown:OverrideText(categoryName)
    end

    local function SelectZone(zoneName)
        self.selectedCategory = nil
        self.selectedZone = zoneName
        self:RefreshDataProvider()
        self.Dropdown:OverrideText(zoneName)
    end

    self.Dropdown:SetupMenu(function(dropdown, rootDescription)
        rootDescription:CreateButton(EVERYTHING_TEXT, SelectAll)
        rootDescription:CreateDivider()

        for _, category in ipairs(CATEGORIES) do
            local submenu = rootDescription:CreateButton(category.name, function()
                SelectCategory(category.name)
            end)
            submenu:SetGridMode(MenuConstants.VerticalGridDirection)
            for _, zoneName in ipairs(category.zones) do
                submenu:CreateButton(zoneName, function()
                    SelectZone(zoneName)
                end)
            end
        end
    end)

    self.Dropdown:SetDefaultText(EVERYTHING_TEXT)
end
