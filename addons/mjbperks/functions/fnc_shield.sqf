params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
private _aDrop =
[
	"shield","Damage Shield","\A3\ui_f\data\GUI\Cfg\Hints\armor_era_ca.paa",
	{   params ["_target"];
		private _vic = vehicle _target;
		[_vic, false] remoteExec ["allowDamage", _vic];
		if (_vic isNotEqualTo player) then {
			[{player allowDamage false}] remoteExec ["call", crew _vic];};
		[{ params ["_vic"];
			[_vic, true] remoteExec ["allowDamage", _vic];
			if (_vic isNotEqualTo player) then {
				[{player allowDamage true}] remoteExec ["call", crew _vic];};
		}, [_vic], 10] call CBA_fnc_waitAndExecute;
		mjb_shieldAvailable = false;
		[{mjb_shieldAvailable}, {mjb_shieldAvailable = true;}, [], mjb_shieldCd, {mjb_shieldAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
	},
	{ params ["_target"]; mjb_shieldAvailable },
	{ },[],[0,0,0],3,[false, true, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_shieldAvailable = true;
[_perkName] call mjb_perks_fnc_updatePerks;