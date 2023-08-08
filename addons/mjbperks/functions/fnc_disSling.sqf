params ["_target"];
if (mjb_regDisposable # 0 isNotEqualTo "") then {
	_target addWeaponGlobal (mjb_regDisposable # 0); _target addSecondaryWeaponItem (mjb_regDisposable # 1);
} else {
	private _rocket = secondaryWeaponMagazine _target;
	if (_rocket isEqualTo []) then {_rocket = [""];};
	mjb_regDisposable = [secondaryWeapon _target, (_rocket # 0)];
};
private _perkName = "disCharge";
if (!isNil ("mjb_" + _perkName + "Statemachine") ) then {
	private _eventHandle = (missionNamespace getVariable [("mjb_" + _perkName + "Statemachine"),nil]);
	_eventHandle call CBA_statemachine_fnc_delete;
	missionNamespace setVariable [("mjb_" + _perkName + "Statemachine"), nil ];
};
private _stateMachine = [configFile >> "MJB_Perks" >> "mjb_perks_disChargeState"] call CBA_statemachine_fnc_createFromConfig;
missionNamespace setVariable [("mjb_" + _perkName + "Statemachine"),
	[_stateMachine]
];