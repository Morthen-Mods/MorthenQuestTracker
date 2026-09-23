local _, MQT = ...

---@class MQT_AreaInfo
---@field mapID? number
---@field instanceID? number
---@field entrance? MQT_Entrance[]

---@class MQT_InstanceInfo
---@field entrance MQT_Entrance[]

---@class MQT_Entrance
---@field areaID number
---@field x number
---@field y number

---@type table<number, MQT_AreaInfo>
MQT.Areas = {
    [1]     = { mapID = 1426 }, -- Dun Morogh
    [3]     = { mapID = 1418 }, -- Badlands
    [4]     = { mapID = 1419 }, -- Blasted Lands
    [8]     = { mapID = 1435 }, -- Swamp of Sorrows
    [10]    = { mapID = 1431 }, -- Duskwood
    [11]    = { mapID = 1437 }, -- Wetlands
    [12]    = { mapID = 1429 }, -- Elwynn Forest
    [14]    = { mapID = 1411 }, -- Durotar
    [15]    =  { mapID = 1445 }, -- Dustwallow Marsh
    [16]    = { mapID = 1447 }, -- Azshara
    [17]    = { mapID = 1413 }, -- The Barrens
    [25]    = {}, -- Blackrock Mountain
    [28]    = { mapID = 1422 }, -- Western Plaguelands
    [33]    = { mapID = 1434 }, -- Stranglethorn Vale
    [36]    = { mapID = 1416 }, -- Alterac Mountains
    [38]    = { mapID = 1432 }, -- Loch Modan
    [40]    = { mapID = 1436 }, -- Westfall
    [41]    = { mapID = 1430 }, -- Deadwind Pass
    [44]    = { mapID = 1433 }, -- Redridge Mountains
    [45]    = { mapID = 1417 }, -- Arathi Highlands
    [46]    = { mapID = 1428 }, -- Burning Steppes
    [47]    = { mapID = 1425 }, -- The Hinterlands
    [51]    = { mapID = 1427 }, -- Searing Gorge
    [85]    = { mapID = 1420 }, -- Tirisfal Glades
    [130]   = { mapID = 1421 }, -- Silverpine Forest
    [139]   = { mapID = 1423 }, -- Eastern Plaguelands
    [141]   = { mapID = 1438 }, -- Teldrassil
    [148]   = { mapID = 1439 }, -- Darkshore
    [209]   = { instanceID = 209 }, -- Shadowfang Keep
    [215]   = { mapID = 1412 }, -- Mulgore
    [267]   = { mapID = 1424 }, -- Hillsbrad Foothills
    [331]   = { mapID = 1440 }, -- Ashenvale
    [357]   = { mapID = 1444 }, -- Feralas
    [361]   = { mapID = 1448 }, -- Felwood
    [400]   = { mapID = 1441 }, -- Thousand Needles
    [405]   = { mapID = 1443 }, -- Desolace
    [406]   = { mapID = 1442 }, -- Stonetalon Mountains
    [440]   = { mapID = 1446 }, -- Tanaris
    [490]   = { mapID = 1449 }, -- Un'Goro Crater
    [491]   = { instanceID = 491 }, -- Razorfen Kraul
    [493]   = { mapID = 1450 }, -- Moonglade
    [618]   = { mapID = 1452 }, -- Winterspring
    [717]   = { instanceID = 717 }, -- The Stockade
    [718]   = { instanceID = 718 }, -- Wailing Caverns
    [719]   = { instanceID = 719 }, -- Blackfathom Deeps
    [721]   = { instanceID = 721 }, -- Gnomeregan
    [722]   = { instanceID = 722 }, -- Razorfen Downs
    [796]   = { instanceID = 796 }, -- Scarlet Monastery
    [1176]  = { instanceID = 1176 }, -- Zul'Farrak
    [1337]  = { instanceID = 1337 }, -- Uldaman
    [1377]  = { mapID = 1451 }, -- Silithus
    [1477]  = { instanceID = 1477 }, -- The Temple of Atal'Hakkar
    [1497]  = { mapID = 1458 }, -- Undercity
    [1519]  = { mapID = 1453 }, -- Stormwind City
    [1537]  = { mapID = 1455 }, -- Ironforge
    [1581]  = { instanceID = 1581 }, -- The Deadmines
    [1583]  = { instanceID = 1583 }, -- Blackrock Spire
    [1584]  = { instanceID = 1584 }, -- Blackrock Depths
    [1585]  = { instanceID = 1584 }, -- Blackrock Depths
    [1637]  = { mapID = 1454 }, -- Orgrimmar
    [1638]  = { mapID = 1456 }, -- Thunder Bluff
    [1657]  = { mapID = 1457 }, -- Darnassus
    [1977]  = { instanceID = 1977 }, -- Zul'Gurub
    [2017]  = { instanceID = 2017 }, -- Stratholme
    [2057]  = { instanceID = 2057 }, -- Scholomance
    [2100]  = { instanceID = 2100 }, -- Maraudon
    [2159]  = { instanceID = 2159 }, -- Onyxia's Lair
    [2257]  = { instanceID = 2257, entrance = { { areaID = 1519, x = 67.6, y = 4.1 }, { areaID = 1537, x = 84.1, y = 53.1 } } }, -- Deeprun Tram
    [2437]  = { instanceID = 2437 }, -- Ragefire Chasm
    [2557]  = { instanceID = 2557 }, -- Dire Maul
    [2597]  = { instanceID = 2597 }, -- Alterac Valley
    [2677]  = { instanceID = 2677 }, -- Blackwing Lair
    [2717]  = { instanceID = 2717 }, -- Molten Core
    [3277]  = { instanceID = 3277 }, -- Warsong Gulch
    [3358]  = { instanceID = 3358 }, -- Arathi Basin
    [3428]  = { instanceID = 3428 }, -- Temple of Ahn'Qiraj
    [3429]  = { instanceID = 3429 }, -- Ruins of Ahn'Qiraj
    [3456]  = { instanceID = 3456 }, -- Naxxramas
    [10022] = { instanceID = 10022 }, -- Dire Maul
    [10023] = { instanceID = 10023 }, -- Dire Maul
    [10024] = { instanceID = 10024 }, -- Dire Maul
    [10025] = { instanceID = 10025 }, -- Dire Maul
    [10030] = { instanceID = 721 }, -- Gnomeregan
    [10074] = { mapID = 1415 }, -- Eastern Kingdoms
    [10089] = { mapID = 947 }, -- Azeroth
}

---@type table<number, MQT_InstanceInfo>
MQT.Dungeons = {
    [209]   = { entrance = { { areaID = 130, x = 44.8, y = 67.8 } } }, -- Shadowfang Keep
    [491]   = { entrance = { { areaID = 17, x = 42.9, y = 90.2 } } }, -- Razorfen Kraul
    [717]   = { entrance = { { areaID = 1519, x = 42.3, y = 58.9 } } }, -- The Stockade
    [718]   = { entrance = { { areaID = 17, x = 46, y = 36.5 } } }, -- Wailing Caverns
    [719]   = { entrance = { { areaID = 331, x = 14.5, y = 14.2 } } }, -- Blackfathom Deeps
    [721]   = { entrance = { { areaID = 1, x = 24.3, y = 39.8 } } }, -- Gnomeregan
    [722]   = { entrance = { { areaID = 17, x = 49, y = 93.9 } } }, -- Razorfen Downs
    [796]   = { entrance = { { areaID = 85, x = 82.6, y = 33.8 } } }, -- Scarlet Monastery
    [1176]  = { entrance = { { areaID = 440, x = 38.7, y = 20.1 } } }, -- Zul'Farrak
    [1337]  = { entrance = { { areaID = 3, x = 44.6, y = 12.1 }, { areaID = 3, x = 65.2, y = 43.5 } } }, -- Uldaman
    [1477]  = { entrance = { { areaID = 8, x = 69.9, y = 53.5 } } }, -- The Temple of Atal'Hakkar
    [1581]  = { entrance = { { areaID = 40, x = 42.5, y = 71.7 } } }, -- The Deadmines
    [1583]  = { entrance = { { areaID = 51, x = 34.8, y = 85.3 }, { areaID = 46, x = 29.4, y = 38.3 } } }, -- Blackrock Spire
    [1584]  = { entrance = { { areaID = 51, x = 34.8, y = 85.3 }, { areaID = 46, x = 29.4, y = 38.3 } } }, -- Blackrock Depths
    [2017]  = { entrance = { { areaID = 139, x = 31.3, y = 15.7 }, { areaID = 139, x = 47.9, y = 23.9 } } }, -- Stratholme
    [2057]  = { entrance = { { areaID = 28, x = 69.7, y = 73.2 } } }, -- Scholomance
    [2100]  = { entrance = { { areaID = 405, x = 29.1, y = 62.5 } } }, -- Maraudon
    [2437]  = { entrance = { { areaID = 1637, x = 52.6, y = 49 } } }, -- Ragefire Chasm
    [2557]  = { entrance = { { areaID = 357, x = 59.2, y = 45.1 } } }, -- Dire Maul
    [10022] = { entrance = { { areaID = 357, x = 62.5, y = 24.9 } } }, -- Dire Maul
    [10023] = { entrance = { { areaID = 357, x = 60.3, y = 30.2 } } }, -- Dire Maul
    [10024] = { entrance = { { areaID = 357, x = 60.3, y = 30.2 } } }, -- Dire Maul
    [10025] = { entrance = { { areaID = 357, x = 60.3, y = 30.2 } } }, -- Dire Maul
}

---@type table<number, MQT_InstanceInfo>
MQT.Raids = {
    [1977]  = { entrance = { { areaID = 33, x = 53.9, y = 17.6 } } }, -- Zul'Gurub
    [2159]  = { entrance = { { areaID = 15, x = 52.6, y = 76.8 } } }, -- Onyxia's Lair
    [2677]  = { entrance = { { areaID = 51, x = 34.8, y = 85.3 }, { areaID = 46, x = 29.4, y = 38.3 } } }, -- Blackwing Lair
    [2717]  = { entrance = { { areaID = 51, x = 34.8, y = 85.3 }, { areaID = 46, x = 29.4, y = 38.3 } } }, -- Molten Core
    [3428]  = { entrance = { { areaID = 1377, x = 28.6, y = 92.3 } } }, -- Temple of Ahn'Qiraj
    [3429]  = { entrance = { { areaID = 1377, x = 28.6, y = 92.3 } } }, -- Ruins of Ahn'Qiraj
    [3456]  = { entrance = { { areaID = 139, x = 39.9, y = 25.8 } } }, -- Naxxramas
}

---@type table<number, MQT_InstanceInfo>
MQT.Battlegrounds = {
    [2597]  = { entrance = { { areaID = 36, x = 39.5, y = 80.2 }, { areaID = 36, x = 63.6, y = 58.8 } } }, -- Alterac Valley
    [3277]  = { entrance = { { areaID = 17, x = 46.5, y = 8.6 }, { areaID = 331, x = 61.7, y = 84.5 } } }, -- Warsong Gulch
    [3358]  = { entrance = { { areaID = 45, x = 73.5, y = 29 }, { areaID = 45, x = 45.4, y = 44.4 } } }, -- Arathi Basin
}
