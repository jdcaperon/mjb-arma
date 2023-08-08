 params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
// perk effects
//mjb_activePerkLoop = [] spawn {};
//private _event = "Fired";
private _playerHandler = ["ace_firedPlayer", { params["_unit", "_weapon", "", "", "", "", "_projectile"];
	[_unit,_weapon,_projectile] call mjb_perks_fnc_telestickHandler;
}] call CBA_fnc_addEventHandler;
missionNamespace setVariable [("mjb_" + _perkName + "CBAHandler"),
	["ace_firedPlayer", _playerHandler]
];
[_perkName] call mjb_perks_fnc_updatePerks;