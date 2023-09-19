private _title = "MJB Arma";

[
    "mjb_slotSaverAI",
    "CHECKBOX",
    ["Enable AI control on disconnect", "When a player disconnects AI will be enabled to prevent death. They may still die due to a vanilla locality issue with the AI."],
    [_title, "Disconnect handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_slotSaverAIExt",
    "CHECKBOX",
    ["Enable Active Disconnect Protection", "The AI will be hidden and attached to group leader or subordinate, then become group leader to prevent locality change death. On returning they will be unhidden and detached."],
    [_title, "Disconnect handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

/*[
    "mjb_autoDeathSync",
    "CHECKBOX",
    ["Automaticlly fix de-sync'd player deaths", "Detects whether players appear dead to each other when they shouldn't and applies the fix automatically."],
    [_title, "Death Handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;*/

[
    "mjb_resyncAction",
    "CHECKBOX",
    ["Enable Resync Action", "Map tab with a list of players and a button to fix if someone is desync'd for you."],
    [_title, "Death Handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_zeusCompKilled",
    "CHECKBOX",
    ["Shift Zeus Comps", "Shift zeus local AI to the server on death, making them ragdoll again for some reason."],
    [_title, "Death Handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

private _category = "AI";
[
    "mjb_disableGunnerBail",
    "CHECKBOX",
    ["Disable Gunner bailout", "Prevents gunners from bailing if they can still shoot."],
    [_title, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_EMfix",
    "CHECKBOX",
    ["Enable possible slow mode fix for EM", "Detects interrupted animations that change animation speed, and attempts to fix speed/climbing ability if broken."],
    [_title, "Enhanced Movement"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_EMFixDiag",
    "CHECKBOX",
    ["Enable message when slow mode fix triggers", "Just something that might help understand the cause, and make the fix better."],
    [_title, "Enhanced Movement"],
    false,
    false
] call CBA_fnc_addSetting;

[
    "mjb_thermalStart",
    "SLIDER",
    ["Thermal Cold Floor", "Sets where coldest color starts, can make thermals unusable at higher settings."],
    [_title, "Thermal Vision"],
    [0, 1, 0, 2],
    true,
    {
        params ["_value"];
        mjb_thermalStart = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_thermalWidth",
    "SLIDER",
    ["Thermal Width", "Sets maximum contrast of thermals, can make thermals unusable at lower settings."],
    [_title, "Thermal Vision"],
    [0, 1, 1, 2],
    true,
    {
        params ["_value"];
        mjb_thermalWidth = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_saveLoadout",
    "LIST",
    ["Loadout save frequency", "At what times/actions your loadout gets saved when persistence is enabled for the mission. No saves will be made when disabled, this is only checked at mission start. When enabled, the saved loadout is erased on death, unless the mission maker specifies otherwise."],
    [_title,"Loadout Persistence"],
    [[0, 1, 2, 3], ["Disable","Closing inventory","Five minute interval", "Both"], 3],
    0,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_dropPlate",
    "CHECKBOX",
    ["Move loot plates to quick loot", "When a unit dies move plates in storage to main inventory screen, allowing scroll action to take them."],
    [_title, "Plates"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateToughness",
    "CHECKBOX",
    ["Enable Plate Toughness", "Players can regen plates over time, starts after delay when not taking damage."],
    [_title, "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenCount",
    "SLIDER",
    ["Plates that regen from toughness", "How many plates are affected by the toughness regen. Limited by plates wearable setting in Armor Plates System."],
    [_title, "Plates"],
    [1, 10, 1, 0],
    true,
    {
        params ["_value"];
        mjb_plateRegenCount = round _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateDelay",
    "SLIDER",
    ["Plate toughness delay", "Seconds before toughness plate starts regen."],
    [_title, "Plates"],
    [1, 600, 5, 1],
    true,
    {
        params ["_value"];
        mjb_plateDelay = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateDelayInter",
    "CHECKBOX",
    ["Delay between plates", "Whether to apply delay between each plate to be regen'd."],
    [_title, "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenSpeed",
    "SLIDER",
    ["Plate toughness regen speed", "Seconds to regen a full plate."],
    [_title, "Plates"],
    [1, 600, 5, 1],
    true,
    {
        params ["_value"];
        mjb_plateRegenSpeed = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenPerTick",
    "SLIDER",
    ["Plate Health per Tick", "Minimum regen to apply, affects tick speed but not the seconds to full plate (Default: 0.5, plate ui does not change from less). Will not regen more than one full plate per tick."],
    [_title, "Plates"],
    [0.1, 100, 0.5, 1],
    false,
    {
        params ["_value"];
        mjb_plateRegenPerTick = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateSteal",
    "CHECKBOX",
    ["Enable plate gain on kill", "When a player damages a non-civ target that dies, they gain plate health."],
    [_title, "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegain",
    "SLIDER",
    ["Plate gain on kill multiplier", "Multiplier for how much plate health is gained on kill, max all plates."],
    [_title, "Plates"],
    [0, 10, 0.2, 2],
    true,
    {
        params ["_value"];
        mjb_plateRegain = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_timerRegain",
    "SLIDER",
    ["Down Timer Regen Coef", "How quickly timer is regen'd. Higher number is faster. 0 disables."],
    [_title, "Plates"],
    [0, 10, 0, 1],
    true,
    {
        params ["_value"];
        mjb_timerRegain = _value;
    },
    true
] call CBA_fnc_addSetting;

[
    "mjb_arsenal_maxLoadoutInjectors",
    "SLIDER",
    ["Max injectors from loadout", "How many injectors a medic can take from arsenal in their inventory. (0 to disable limit)"],
    [_title, "Retroactive Arsenal"],
    [0, 50, 5, 0],
    true,
    {
        params ["_value"];
        mjb_arsenal_maxLoadoutInjectors = round _value;
    },
    true
] call CBA_fnc_addSetting;