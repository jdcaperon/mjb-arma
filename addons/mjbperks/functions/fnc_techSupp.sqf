params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
private _aDrop =
[
	"tSupp","Technical Support","\A3\ui_f\data\map\vehicleicons\iconStaticMG_ca.paa",
	{   params ["_target"];
		_target spawn mjb_perks_fnc_techSupport;
	},
	{   params ["_target"];
			mjb_techSuppAvailable && {(!alive mjb_technical || {mjb_technical getHitPointDamage "hitEngine" >= 0.9 || {mjb_technical getHitPointDamage "hitGun" >= 0.9 || {_target distance2D mjb_technical > 1500}}})} },
	{ },[],[0,0,0],3,[false, false, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_techSuppAvailable = true;
if (isNil "mjb_technical") then {mjb_technical = objNull;};
[_perkName] call mjb_perks_fnc_updatePerks;