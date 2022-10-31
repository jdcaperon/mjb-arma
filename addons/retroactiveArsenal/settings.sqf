/*[
    "mjb_arsenal_maxLoadoutInjectors",
    "SLIDER",
    ["Max injectors from loadout", "How many injectors a medic can take from arsenal in their inventory."],
    ["MJB Arma", "Retroactive Arsenal"],
    [1, 50, 5, 0],
    true,
    {
        params ["_value"];
        mjb_arsenal_maxLoadoutInjectors = round _value;
    },
    true
] call CBA_fnc_addSetting;
*/

[
    "mjb_slotSaverAI",
    "CHECKBOX",
    ["Enable AI control on disconnect", "When a player disconnects AI will take control, saving their slot."],
    ["MJB Arma", "Disconnect handling"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_saveLoadout",
    "LIST",
    ["Loadout save frequency", "At what times/actions your loadout gets saved when persistence is enabled for the mission. No saves will be made when disabled, this is only checked at mission start. When enabled, the saved loadout is erased on death, unless the mission maker specifies otherwise."],
    ["MJB Arma","Loadout Persistence"],
    [[0, 1, 2, 3], ["Disable","Closing inventory","Five minute interval", "Both"], 3],
    0,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateToughness",
    "CHECKBOX",
    ["Enable Plate Toughness", "Players regen their first plate, starts after delay when not taking damage."],
    ["MJB Arma", "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenCount",
    "SLIDER",
    ["Plates to regen", "How many plates are affected by the toughness regen. Limited by plates wearable setting in Armor Plates System."],
    ["MJB Arma", "Plates"],
    [1, 10, 1, 0],
    true,
    {
        params ["_value"];
        mjb_plateDelay = round _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateDelay",
    "SLIDER",
    ["Plate toughness delay", "Seconds before toughness plate starts regen."],
    ["MJB Arma", "Plates"],
    [1, 600, 5, 1],
    true,
    {
        params ["_value"];
        mjb_plateDelay = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateRegenSpeed",
    "SLIDER",
    ["Plate toughness regen speed", "Seconds to regen a full plate."],
    ["MJB Arma", "Plates"],
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
    ["MJB Arma", "Plates"],
    [0.1, 100, 0.5, 1],
    false,
    {
        params ["_value"];
        mjb_plateRegenSpeed = _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_plateSteal",
    "CHECKBOX",
    ["Enable plate gain on kill", "When a player damages a non-civ target that dies, they gain plate health."],
    ["MJB Arma", "Plates"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_plateRegain",
    "SLIDER",
    ["Plate gain on kill multiplier", "Multiplier for how much plate health is gained on kill, max all plates."],
    ["MJB Arma", "Plates"],
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
    ["MJB Arma", "Plates"],
    [0, 10, 0, 1],
    true,
    {
        params ["_value"];
        mjb_timerRegain = _value;
    },
    true
] call CBA_fnc_addSetting;