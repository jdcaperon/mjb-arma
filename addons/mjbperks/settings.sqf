[
    "mjb_perks",
    "CHECKBOX",
    ["Enable perk system", "Perks for players to choose."],
    ["MJB Arma Perks"],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_perkPoints",
    "SLIDER",
    ["Perk points", "How many points players have for perks."],
    ["MJB Arma Perks"],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_perkPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

/*private _perkName = "Perk Name";
[
    "mjb_perkNameEnabled",
    "CHECKBOX",
    ["Enable " + _perkName, "Perk that does x."],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_perkNamePoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_perkNamePoints = round _value;
    },
    true
] call CBA_fnc_addSetting;*/

private _perkName = "Plate drop";
[
    "mjb_plateDropEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows player to call a drop of 9 plates on a 20 min. cooldown. Req. Medic/Leader"],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_plateDropPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_plateDropPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Extra Conditioning";
[
    "mjb_extraHpEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Player gets x% more max health."],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_extraHpPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_extraHpPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_extraHpMult",
    "SLIDER",
    [(_perkName + " HP Multiplier"), "Multiplied by default player or mission set max hp for new max HP with the perk active."],
    ["MJB Arma Perks", "Individual Perks"],
    [1, 5, 1.50, 2],
    true,
    {
        params ["_value"];
        mjb_extraHpMult = (parseNumber (_value toFixed 2));
    }
] call CBA_fnc_addSetting;

private _perkName = "Pack Sling";
[
    "mjb_packSlingEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Player can store an extra weapon from any slot."],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_packSlingPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_packSlingPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Sneak Attack";
[
    "mjb_sneakAttackEnabled",
    "CHECKBOX",
    ["Enable " + _perkName, "Perk that make hits on less aware enemies do more damage."],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_sneakAttackPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_sneakAttackPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Dragon's breath";
[
    "mjb_dragonEnabled",
    "CHECKBOX",
    [("Enable" + _perkName), "Perk that makes buckshot have a chance to ignite targets."],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_dragonPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_dragonPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Telestick";
[
    "mjb_telestickEnabled",
    "CHECKBOX",
    [("Enable" + _perkName), "Allows players to teleport with chemlights."],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_telestickPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_telestickPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;


mjb_eyesEnabled = false;
mjb_eyesPoints = 0;/*
private _perkName = "Hawk eyes";
[
    "mjb_eyesEnabled",
    "CHECKBOX",
    ["Enable Hawk eyes", "Perk that let's players zoomy eyes farther but not while aimed."],
    ["MJB Arma Perks", "Individual Perks"],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_eyesPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    ["MJB Arma Perks", "Individual Perks"],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_eyesPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;