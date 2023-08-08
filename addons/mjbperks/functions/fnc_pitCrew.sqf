params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
private _aDrop =
[
	"pitCrew","Pit Crew","\A3\ui_f\data\GUI\Cfg\Hints\Driving_ca.paa",
	{   params ["_target"];
		private _vic = vehicle _target;
		private _hitpoints = ((getAllHitPointsDamage _vic) select 0);
		[{ params ["_vic"];
			{if !(_x in _hitpoints) then {continue}; _vic setHitPointDamage [_x,0]} forEach ["hitltrack","hitrtrack","hitlfwheel","hitlbwheel","hitrfwheel","hitrbwheel","hitrmwheel","hitlmwheel","hitlf2wheel","hitrf2wheel"];
		}, [_vic], 15] call CBA_fnc_waitAndExecute;
		mjb_pitCrewAvailable = false;
		[{mjb_pitCrewAvailable}, {mjb_pitCrewAvailable = true;}, [], mjb_pitCrewCd, {mjb_pitCrewAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
	},
	{ params ["_target"]; mjb_pitCrewAvailable && {(vehicle _target) isNotEqualTo _target} },
	{ },[],[0,0,0],3,[false, true, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_pitCrewAvailable = true;
[_perkName] call mjb_perks_fnc_updatePerks;