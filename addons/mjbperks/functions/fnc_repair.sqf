params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
private _aDrop =
[
	"mjb_repair","Emergency Repair","\A3\ui_f\data\GUI\Cfg\Hints\VehicleRepair_ca.paa",
	{   params ["_target"];
		private _vic = vehicle _target;
		_vic setHitPointDamage ["hitfuel",0];
		private _damage = getAllHitPointsDamage _vic;
		private _hitpoints = (_damage select 0);
		_damage = (_damage select 2);
		private _index = -1;
		{
			_index = _index + 1;
			private _oldDamage = (_damage select _index);
			if (_oldDamage >= 0.9) then {continue};
			_newDamage = (_oldDamage - 0.2) max 0;
			_vic setHitPointDamage [_x,_newDamage];

		} forEach _hitpoints;
		mjb_repairAvailable = false;
		[{mjb_repairAvailable}, {mjb_repairAvailable = true;}, [], mjb_repairCd, {mjb_repairAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
	},
	{ params ["_target"]; mjb_repairAvailable && {(vehicle _target) isNotEqualTo _target} },
	{ },[],[0,0,0],3,[false, true, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_repairAvailable = true;
[_perkName] call mjb_perks_fnc_updatePerks;