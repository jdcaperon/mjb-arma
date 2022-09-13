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

