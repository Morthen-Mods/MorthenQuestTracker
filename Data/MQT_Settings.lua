local _, MQT = ...

MQT.Settings = {}

MQT.Settings.default = {
    MQTSettings = {
        point = nil,
        tab = 1,
        filters = {},
        expanded = {},
        hideCompleted = false,
        hideOtherFaction = true,
        showLevel = false,
        colorByDifficulty = false,
        minimap = { hide = false, angle = 205 },
        selected = nil
    }
}