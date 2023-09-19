params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
// perk effects
//mjb_activePerkLoop = [] spawn {};
//private _event = "Fired";
private _playerHandler = ["ace_firedPlayer", { params["", "_weapon", "", "", "", "", "_projectile"];
		_projectile addEventHandler ["SubmunitionCreated", {
			params ["","_submunitionProjectile"];
			[_submunitionProjectile] spawn mjb_perks_fnc_randHandler;
		}];
		if (_weapon isEqualTo "Throw") exitWith {};
		[_projectile] spawn mjb_perks_fnc_randHandler;
	}] call CBA_fnc_addEventHandler;
missionNamespace setVariable [("mjb_" + _perkName + "CBAHandler"),
	["ace_firedPlayer", _playerHandler]
];
//mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
[_perkName] call mjb_perks_fnc_updatePerks;