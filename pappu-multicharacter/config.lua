Config = {}
Config.Interior = vector3(-1004.36, -477.9, 51.63) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(-1004.36, -477.9, 51.63) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(-1007.326, -477.578, 50.028, 208.64) -- Create preview ped at these coordinates
Config.SecondPedCoords = vector4(-1005.9, -476.0, 50.028, 180.0) -- Second preview ped location
Config.ThirdPedCoords = vector4(-1009.077, -475.699, 50.693, 210.478) -- sitchair
Config.FourthPedCoords = vector4(-1005.866, -479.814, 50.027, 33.839) -- sit5
Config.FivePedCoords = vector4(-1008.631, -474.465, 50.027, 26.839) --jleancar
Config.SixthPedCoords = vector4(-1009.076, -479.427, 50.027, 166.983) -- think
Config.SeventhPedCoords = vector4(-1007.537, -477.281, 50.028, 29.84) -- cop
Config.HiddenCoords = vector4(-1001.11, -478.06, 50.03, 24.55) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(-1011.480, -476.256, 52.161, 255.38) -- Camera coordinates for character preview screen
Config.EnableDeleteButton = true -- Define if the player can delete the character or not

-- Preview slots with associated idle animations
-- Each slot entry has a `coords` vector and the `anim` that the ped should play
Config.PreviewSlots = {
    {coords = vector4(-1007.3, -477.6, 50.028, 208.6), anim = "WORLD_HUMAN_HANG_OUT_STREET"},
    {coords = vector4(-1005.9, -476.0, 50.028, 180.0), anim = "WORLD_HUMAN_STAND_IMPATIENT"},
    {coords = vector4(-1004.0, -476.5, 50.028, 160.0), anim = "WORLD_HUMAN_SMOKING_POT"},
    {coords = vector4(-1003.0, -478.0, 50.028, 140.0), anim = "WORLD_HUMAN_LEANING"},
    {coords = vector4(-1006.5, -479.0, 50.028, 200.0), anim = "WORLD_HUMAN_DRINKING"},
    {coords = vector4(-1008.2, -475.3, 50.028, 220.0), anim = "WORLD_HUMAN_MUSCLE_FLEX"},
    {coords = vector4(-1002.0, -475.5, 50.028, 130.0), anim = "WORLD_HUMAN_AA_SMOKE"}
}

-- Fallback animation pool if none supplied
Config.PreviewSlots = {
    vector4(-1007.3, -477.6, 50.028, 208.6),
    vector4(-1005.9, -476.0, 50.028, 180.0),
    vector4(-1004.0, -476.5, 50.028, 160.0),
    vector4(-1003.0, -478.0, 50.028, 140.0),
    vector4(-1006.5, -479.0, 50.028, 200.0),
    vector4(-1008.2, -475.3, 50.028, 220.0),
    vector4(-1002.0, -475.5, 50.028, 130.0)
}

Config.PreviewAnimations = {
    "WORLD_HUMAN_HANG_OUT_STREET",
    "WORLD_HUMAN_STAND_IMPATIENT",
    "WORLD_HUMAN_SMOKING_POT",
    "WORLD_HUMAN_LEANING",
    "WORLD_HUMAN_DRINKING",
    "WORLD_HUMAN_MUSCLE_FLEX",
    "WORLD_HUMAN_AA_SMOKE"
}

Config.inventoryexport =  "pappu-inventorynp"

Config.DefaultNumberOfCharacters = 2 --  Max 4 // Dont Go More Than 4
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}
