local _, MQT = ...

MQT_QuestScrollFrameMixin = {}

-- Category groups behind each tab (see MQT_MainFrameMixin / MQT_ModeTabButtonMixin).
-- Each MQT_QuestScrollFrameTemplate instance picks its group via the
-- `categoryGroup` KeyValue set on it in TrackerTemplates.xml. A group with a
-- single category (Dungeons/Raids) is listed flat in the dropdown; a group
-- with several categories (WorldZones, ClassesAndProfessions) keeps them as
-- separate flyout submenus.
--
-- Also doubles as the dummy quest data source: each zone gets a handful of
-- fake quests until real per-zone quest data is wired up.
local CATEGORY_GROUPS = {
    ClassesAndProfessions = {
        {
            name = "Classes",
            zones = {
                "Druid", "Hunter", "Mage", "Paladin", "Priest", "Rogue",
                "Shaman", "Warlock", "Warrior",
            },
        },
        {
            name = "Professions",
            zones = {
                "Alchemy", "Blacksmithing", "Cooking", "Enchanting",
                "Engineering", "First Aid", "Fishing", "Herbalism",
                "Leatherworking", "Mining", "Skinning", "Tailoring",
            },
        },
    },
    Dungeons = {
        {
            name = "Dungeon",
            zones = {
                "Blackfathom Deeps", "Blackrock Depths", "Dire Maul",
                "Gnomeregan", "Lower Blackrock Spire", "Maraudon",
                "Ragefire Chasm", "Razorfen Downs", "Razorfen Kraul",
                "Scarlet Monastery", "Shadowfang Keep", "Sunken Temple",
                "The Deadmines", "The Stockade", "Uldaman",
                "Upper Blackrock Spire", "Wailing Caverns", "Zul'Farrak",
            },
        },
    },
    Raids = {
        {
            name = "Raids",
            zones = {
                "Blackwing Lair", "Molten Core", "Naxxramas", "Onyxia's Lair",
                "Ruins of Ahn'Qiraj", "Temple of Ahn'Qiraj", "Zul'Gurub",
            },
        },
    },
    WorldZones = {
        {
            name = "Eastern Kingdoms",
            zones = {
                "Arathi Highlands", "Badlands", "Blasted Lands", "Burning Steppes",
                "Dun Morogh", "Duskwood", "Eastern Plaguelands", "Elwynn Forest",
                "Hillsbrad Foothills", "Ironforge", "Loch Modan",
                "Redridge Mountains", "Searing Gorge", "Silverpine Forest",
                "Stormwind City", "Stranglethorn Vale", "Swamp of Sorrows",
                "The Hinterlands", "Tirisfal Glades", "Undercity",
                "Western Plaguelands", "Westfall", "Wetlands",
            },
        },
        {
            name = "Kalimdor",
            zones = {
                "Ashenvale", "Azshara", "Darkshore", "Darnassus", "Desolace",
                "Durotar", "Dustwallow Marsh", "Felwood", "Feralas",
                "Moonglade", "Mulgore", "Orgrimmar", "Silithus",
                "Stonetalon Mountains", "Tanaris", "Teldrassil", "The Barrens",
                "Thousand Needles", "Thunder Bluff", "Un'Goro Crater",
                "Winterspring",
            },
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

    self.categories = CATEGORY_GROUPS[self.categoryGroup] or {}

    -- nil/nil means "no filter" / show every category and zone in this tab.
    self.selectedCategory = nil
    self.selectedZone = nil
    self:RefreshDataProvider()
    self:SetupGroupFilterDropdown()
end

-- Test data to exercise scroll + collapse behavior; remove once real quest data is wired up.
function MQT_QuestScrollFrameMixin:RefreshDataProvider()
    local dataProvider = CreateTreeDataProvider()
    local zoneCount = 0
    for _, category in ipairs(self.categories) do
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

        if #self.categories == 1 then
            -- Only one category in this tab (Dungeons/Raids); nesting it
            -- behind its own submenu would just add a pointless extra click,
            -- so list its zones directly at the root instead. SetGridMode
            -- isn't used here since it would also grid the Everything button
            -- and divider above (grid mode applies to the whole description).
            for _, zoneName in ipairs(self.categories[1].zones) do
                rootDescription:CreateButton(zoneName, function()
                    SelectZone(zoneName)
                end)
            end
        else
            for _, category in ipairs(self.categories) do
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
        end
    end)

    self.Dropdown:SetDefaultText(EVERYTHING_TEXT)
end