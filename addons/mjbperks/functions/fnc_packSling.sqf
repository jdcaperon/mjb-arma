params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
// perk effects
//mjb_activePerkLoop = [] spawn {};
if (isNil "mjb_pSlingHandler") then {
	private _event = "Killed";
	missionNamespace setVariable [("mjb_pSlingHandler"),
		([ _event, (player addEventHandler [_event, { params ["_unit"];
			if (!isNil "mjb_storedWeapon") then {
				_unit spawn { params ["_unit"]; sleep 1;
					private _slung = mjb_storedWeapon;
					private _slingContainer = (_slung # 2);
					deleteVehicle _slingContainer;
					_slung = (_slung # 0);
					private _deathBox = (_unit nearObjects ["WeaponHolderSimulated",2] select 0);
					_deathBox addWeaponWithAttachmentsCargoGlobal [_slung, 1];
					mjb_storedWeapon = nil;
				};
			};
			_unit removeEventHandler [_thisEvent,_thisEventHandler];
		}] ) ])
	];
};
private _pSling =
[
	"pSling","Sling current weapon","z\mjb\addons\perks\data\packSling_ca.paa",
	mjb_perks_fnc_pSling,
	{ true },
	{},[],[0,0,0],3,[false, false, false, false, true],
	{   params ["", "", "", "_actionData"];
		if (!isNil "mjb_storedWeapon") then {
			if ((mjb_storedWeapon # 1) < 0) exitWith {
				private _class = mjb_storedWeapon # 3;
				private _weapon = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
				_actionData set [1, ("Equip/Swap to: " + _weapon)];
			};
			private _class = ((mjb_storedWeapon # 0) # 0);
			private _weapon = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
			_actionData set [1, ("Equip/Swap to: " + _weapon)];
		};
	}
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _player;
private _path = [_addClass, 1, ["ACE_SelfActions"], _pSling] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
private _stateMachine = [configFile >> "MJB_Perks" >> "mjb_perks_slingState"] call CBA_statemachine_fnc_createFromConfig;
missionNamespace setVariable [("mjb_" + _perkName + "Statemachine"),
	[_stateMachine]
];
[_perkName] call mjb_perks_fnc_updatePerks;