params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
	mjb_disChargeCdDone = nil; mjb_regDisposable = nil;
};
// perk effects
//mjb_activePerkLoop = [] spawn {};
/*private _event = "Killed";
missionNamespace setVariable [("mjb_pSlingHandler"),
	([ _event, (player addEventHandler [_event, { params ["_unit"];
		if (!isNil "mjb_storedWeapon") then {
			private _slingContainter = (mjb_storedWeapon # 2);
			_slingContainter enableSimulationGlobal true;
			//[_slingContainter,false] remoteExec ["lockInventory",0];
			//remoteExec ["", (_unit getVariable ["mjb_slingName",nil]) ];
			mjb_storedWeapon = nil;
		};
		_unit removeEventHandler [_thisEvent,_thisEventHandler];
	}] ) ])
];*/

if (isNil "mjb_regDisposable") then {mjb_regDisposable = ["",""];};

private _disSling =
[
	"disSling","Register Disposable","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\secondaryWeapon_ca.paa",
	mjb_perks_fnc_disSling,
	{ private _class = secondaryWeapon _target; !(_class in ["",(mjb_regDisposable # 0)]) &&
		{!("Used" in (getText (configFile >> "CfgWeapons" >> _class >> "displayName"))) &&
		{!("used" in (getText (configFile >> "CfgWeapons" >> _class >> "displayName"))) &&
		{(getNumber (configFile >> "CfgWeapons" >> _class >> "rhs_disposable")) isEqualTo 1 ||
		{((getText (configFile >> "CfgWeapons" >> _class >> "EventHandlers" >> "fired")) isEqualTo "_this call CBA_fnc_firedDisposable")} } } } },
	{},[],[0,0,0],3,[false, false, false, false, true],
	{   params ["", "", "", "_actionData"];
		if (!isNil "mjb_regDisposable" && {(mjb_regDisposable # 0) isNotEqualTo ""}) then {
			private _class = (mjb_regDisposable # 0);
			private _weapon = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
			_actionData set [1, ("Overwrite: " + _weapon)];
		};
	}
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf player;
private _path = [_addClass, 1, ["ACE_SelfActions"], _disSling] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
[_perkName] call mjb_perks_fnc_updatePerks;