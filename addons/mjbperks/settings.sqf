private _mod = "MJB Arma Perks";

[
    "mjb_perks",
    "CHECKBOX",
    ["Enable perk system", "Perks for players to choose."],
    [_mod],
    false,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_perkPoints",
    "SLIDER",
    ["Perk points", "How many points players have for perks. Needs mission restart."],
    [_mod],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_perkPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

[
    "mjb_enableFlags",
    "CHECKBOX",
    ["Enable Flags", "Enable players to self attach/remove RATS or Canadian flags, from Self interact > Equipment."],
    [_mod],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;

[
    "mjb_fingerRange",
    "SLIDER",
    [("Finger Range"), "Range in meters where point will disable the pointee's weapon. 0 disables."],
    [_mod],
    [0, 50, 2, 1],
    true,
    {
        params ["_value"];
        mjb_fingerRange = (parseNumber (_value toFixed 1));
    }
] call CBA_fnc_addSetting;


private _category = "Individual Perks";

/*private _perkName = "Perk Name";
[
    "mjb_perkNameEnabled",
    "CHECKBOX",
    ["Enable " + _perkName, "Perk that does x."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_perkNamePoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
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
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_plateDropPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_plateDropPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_plateDropCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 1200, 0],
    true,
    {
        params ["_value"];
        mjb_plateDropCd = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Ammo drop";
[
    "mjb_ammoDropEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows player to call a drop of rockets and an ammo arsenal on an X min. cooldown. Req. Leader"],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_ammoDropPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_ammoDropPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_ammoDropCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 3600, 0],
    true,
    {
        params ["_value"];
        mjb_ammoDropCd = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Extra Conditioning";
[
    "mjb_extraHpEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Player gets x% more max health."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_extraHpPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
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
    [_mod, _category],
    [1, 5, 1.50, 2],
    true,
    {
        params ["_value"];
        mjb_extraHpMult = (parseNumber (_value toFixed 2));
    }
] call CBA_fnc_addSetting;

private _perkName = "Doorkicker";
[
    "mjb_flashDoorEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Player can perform a flash and kick action (self-interact at a door, with ace flashbangs in inventory)."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_flashDoorPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_flashDoorPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Telestick";
[
    "mjb_telestickEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows players to teleport with chemlights."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_telestickPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_telestickPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_teleFix",
    "CHECKBOX",
    [(_perkName + " fix"), "Disables pick up and throw causing additional teleports."],
    [_mod, _category],
    true,
    true
] call CBA_fnc_addSetting;

private _perkName = "Heartbeat Sensor";
[
    "mjb_heartEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows players to see units outside their group on radar within a range."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_heartPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_heartPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_heartColor",
    "COLOR",
    ["Heartbeat Sensor color", "Units detected by heartbeat will flash between this color and the tracking color in DUI - Main."],
    [_mod, _category],
    [1.0, 0.48, 0.45],
    false
] call CBA_fnc_addSetting;
[
    "mjb_heartRange",
    "SLIDER",
    [(_perkName + " Range"), "Range in meters where heartbeat sensor will detect units."],
    [_mod, _category],
    [1, 50, 20, 1],
    true,
    {
        params ["_value"];
        mjb_heartRange = (parseNumber (_value toFixed 1));
    }
] call CBA_fnc_addSetting;
[
    "mjb_heartCenter",
    "SLIDER",
    [(_perkName + " Center"), "Distance in front of the user the detection radius will be centered on."],
    [_mod, _category],
    [0, 50, 0, 1],
    true,
    {
        params ["_value"];
        mjb_heartCenter = (parseNumber (_value toFixed 1));
    }
] call CBA_fnc_addSetting;

private _perkName = "Plate Up";
[
    "mjb_plateUpEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Plate regen starts immediately."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_plateUpPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_plateUpPoints = round _value;
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
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_eyesPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_eyesPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;*/

private _category = "Weapon Perks";

private _perkName = "Pack Sling";
[
    "mjb_packSlingEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Player can store an extra weapon from any slot."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_packSlingPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_packSlingPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Dragon's breath";
[
    "mjb_dragonEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Perk that makes buckshot have a chance to ignite targets."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_dragonPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_dragonPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Bullet Lottery";
[
    "mjb_randEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Perk that makes buckshot have a chance to ignite targets."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_randPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_randPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Disposable Recharge";
[
    "mjb_disChargeEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Player can register a disposable to recharge after a cooldown."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_disChargePoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_disChargePoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_disChargeCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 1800, 0],
    true,
    {
        params ["_value"];
        mjb_disChargeCd = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Sneak Attack";
[
    "mjb_sneakAttackEnabled",
    "CHECKBOX",
    ["Enable " + _perkName, "Perk that make hits on less aware enemies do more damage."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_sneakAttackPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 500, 0],
    true,
    {
        params ["_value"];
        mjb_sneakAttackPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _category = "Vehicle Perks";

private _perkName = "Technical Support";
[
    "mjb_techSuppEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows player to call a technical in, X min. cooldown. Limited to one active for the platoon."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_techSuppPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_techSuppPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_techSuppCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 3600, 0],
    true,
    {
        params ["_value"];
        mjb_techSuppCd = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Summon Familiar";
[
    "mjb_familiarEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows player to call a technical in, X min. cooldown. Limited to one active for the platoon."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_familiarPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_familiarPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_familiarCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 3600, 0],
    true,
    {
        params ["_value"];
        mjb_familiarCd = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_perks_familiar",
    "LIST",
    [_perkName + " familiar", "What vehicle " + _perkName + " summons."],
    [_mod, _category],
    [[0,1],["Leopard 2A6", "M6 Limebacker"], 0],
    0,
    {params ["_value"]; mjb_perks_familiar = _value; },
    true
] call CBA_fnc_addSetting;

//["CUP_B_Leopard2A6_HIL","CUP_B_M6LineBacker_NATO_T"]

private _perkName = "Pit crew";
[
    "mjb_pitCrewEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows player to get wheel/treads repaired after a short delay."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_pitCrewPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_pitCrewPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_pitCrewCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 1200, 0],
    true,
    {
        params ["_value"];
        mjb_pitCrewCd = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Emergency Repair";
[
    "mjb_repairEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Allows quick repair of fuel tank and components that are still functional."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_repairPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_repairPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_repairCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 1800, 0],
    true,
    {
        params ["_value"];
        mjb_repairCd = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Re-arm";
[
    "mjb_rearmEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Reloads vehicle with 50% of the difference between max and empty magazines."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_rearmPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_rearmPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_rearmCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 1800, 0],
    true,
    {
        params ["_value"];
        mjb_rearmCd = round _value;
    },
    true
] call CBA_fnc_addSetting;

private _perkName = "Damage Shield";
[
    "mjb_shieldEnabled",
    "CHECKBOX",
    [("Enable " + _perkName), "Ten second invulnerability."],
    [_mod, _category],
    true,
    true,
    { },
    true
] call CBA_fnc_addSetting;
[
    "mjb_shieldPoints",
    "SLIDER",
    [_perkName + " cost", "How many points " + _perkName + " costs."],
    [_mod, _category],
    [0, 5000, 1000, 0],
    true,
    {
        params ["_value"];
        mjb_shieldPoints = round _value;
    },
    true
] call CBA_fnc_addSetting;
[
    "mjb_shieldCd",
    "SLIDER",
    [_perkName + " coooldown", "How many seconds the cooldown of " + _perkName + " lasts."],
    [_mod, _category],
    [0, 7200, 1500, 0],
    true,
    {
        params ["_value"];
        mjb_shieldCd = round _value;
    },
    true
] call CBA_fnc_addSetting;