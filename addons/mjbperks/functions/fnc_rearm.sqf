params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
private _aDrop =
[
	"mjb_rearm","Re-arm","\A3\ui_f\data\GUI\Cfg\Hints\VehicleAmmo_ca.paa",
	{   params ["_target"];
		private _vic = vehicle _target;
		[_vic, { params ["_vic"];
			private _turrets = [[-1]] + (allTurrets [_vic, false]);
			//for each turret, add 50% of (default load - remaining)
			{
				private _turret = _x;
			  [[_vic, _turret], { params ["_vic", "_turret"];
				private _mags = _vic magazinesTurret [_turret, true];
				private _magsEmpty = (_mags - (_vic magazinesTurret [_turret, false]));
				while {_mags isNotEqualTo []} do {
					private _magClass = (_mags select 0);
					private _total = ({_x isEqualTo _magClass} count _mags);
					private _empty = ({_x isEqualTo _magClass} count _magsEmpty);
					private _reload = ((_total - (ceil (_empty / 2))) max 1);
					private _extra = _total - _reload;
					_vic removeMagazinesTurret [_magClass, _turret];
					for "_i" from 1 to _reload do {_vic addMagazineTurret [_magClass, _turret];};
					for "_i" from 1 to _extra do {_vic addMagazineTurret [_magClass, _turret, 0];};
					for "_i" from 1 to _total do {
						private _delete = (_mags findIf {_x isEqualTo _magClass});
						if (_delete > -1) then {_mags deleteAt _delete;};
					};
					for "_i" from 1 to _empty do {
						private _delete = (_magsEmpty findIf {_x isEqualTo _magClass});
						if (_delete > -1) then {_magsEmpty deleteAt _delete;};
					};
				};
					private _mags = _vic magazinesTurret [_turret, false];
					{
						private _curgun = _x;
						{ _vic loadMagazine [_turret, _curgun, _x];
							if (((weaponState [_vic,_turret,_curgun]) select 6) > 0) exitWith {};
						} forEach _mags;
					} forEach (_vic weaponsTurret _turret);
				}] remoteExec ["call", (_vic turretOwner _turret)];
			} forEach _turrets;
		}] remoteExec ["call", 2];
		mjb_rearmAvailable = false;
		[{mjb_rearmAvailable}, {mjb_rearmAvailable = true;}, [], mjb_rearmCd, {mjb_rearmAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
	},
	{ params ["_target"]; mjb_rearmAvailable && {(vehicle _target) isNotEqualTo _target} },
	{ },[],[0,0,0],3,[false, true, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_rearmAvailable = true;
[_perkName] call mjb_perks_fnc_updatePerks;