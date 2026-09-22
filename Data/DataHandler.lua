local addonName, MQT = ...

-- Placeholder/test data for the tracker display. Each group is rendered as
-- its own collapsible block; each entry is a single line with a checked
-- status. Real quest/waypoint data can replace this table later.
MQT.Data = {
    {
        name = "Zephras Isle",
        entries = {
            { text = "[9] A Firm Response", checked = true },
            { text = "[9] Unwelcome Spirits", checked = true },
            { text = "[11] Aid For The Refugees", checked = true },
            { text = "[11] Feathers for Binding", checked = true },
            { text = "[11] The Fate of a Loved One", checked = true },
            { text = "[11] Unwanted and Unworthy", checked = true },
            { text = "[12] Tears of the Lady", checked = true },
        },
    },
    {
        name = "Shaman",
        entries = {
            { text = "[10] Totemic Restoration", checked = false },
            { text = "[10] Spirits of the Land", checked = false },
        },
    },
}
