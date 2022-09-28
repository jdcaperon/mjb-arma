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

