params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
	private _newHP = mjb_defaultHP;
	mjb_defaultHP = nil;
	_target setVariable ["diw_armor_plates_main_maxHp", _newHP, true];
	[_target, _newHP] spawn {params ["_target","_newHP"]; sleep 1; _target setVariable ["diw_armor_plates_main_hp", (_newHP + 0.001), true]; [_target] call diw_armor_plates_main_fnc_updateHPUi;};
	_target call diw_armor_plates_main_fnc_fillVestWithPlates;
	[_target] call diw_armor_plates_main_fnc_updatePlateUi;
};
// perk effects
mjb_defaultHP = _target getVariable ["diw_armor_plates_main_maxHp", diw_armor_plates_main_maxPlayerHP];
private _newHP = (ceil (mjb_defaultHP * mjb_extraHpMult));
_target setVariable ["diw_armor_plates_main_maxHp", _newHP, true];
_target setVariable ["diw_armor_plates_main_hp", (_newHP + 0.001), true];
[player] call diw_armor_plates_main_fnc_updateHPUi;
_target call diw_armor_plates_main_fnc_fillVestWithPlates;
[player] call diw_armor_plates_main_fnc_updatePlateUi;
//private _event = "Fired";
//mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
[_perkName] call mjb_perks_fnc_updatePerks;