/*
    * Arguments:
      * 0: Name of the perk to remove

    ex.: ["perkName"] call mjb_perks_fnc_perkCleanup;
*/
params ["_remove"];

if !(canSuspend) exitWith {mjb_perkYeet = (_this spawn mjb_perks_fnc_perkCleanup);};

if (_remove isEqualTo true) exitWith {
	private _i = 0;
    {
        missionNamespace setVariable [("mjb_perkYeet_" + str _i),([_x] spawn mjb_perks_fnc_perkCleanup)];
		_i = _i + 1;
    } forEach mjb_activePerks;
};

if (!isNil ("mjb_" + _remove + "Loop") ) then {
    private _scriptHandle = (missionNamespace getVariable [("mjb_" + _remove + "Loop"),nil]);
//systemChat "removing spawn loop";
    missionNamespace setVariable [("mjb_" + _remove + "End"), true];
    //terminate _scriptHandle;
    waitUntil { scriptDone _scriptHandle };
    missionNamespace setVariable [("mjb_" + _remove + "End"), nil];
    missionNamespace setVariable [("mjb_" + _remove + "Loop"), nil ];
};

if (!isNil ("mjb_" + _remove + "Handler") ) then {
    private _eventHandle = (missionNamespace getVariable [("mjb_" + _remove + "Handler"),nil]);
//systemChat "removing handler";
    player removeEventHandler _eventHandle;
    missionNamespace setVariable [("mjb_" + _remove + "Handler"), nil ];
};

if (!isNil ("mjb_" + _remove + "CBAHandler") ) then {
    private _eventHandle = (missionNamespace getVariable [("mjb_" + _remove + "CBAHandler"),nil]);
//systemChat "removing cba handler";
    _eventHandle call CBA_fnc_removeEventHandler;
    missionNamespace setVariable [("mjb_" + _remove + "CBAHandler"), nil ];
};

if (!isNil ("mjb_" + _remove + "CBAHandlerVic") ) then {
    private _eventHandle = (missionNamespace getVariable [("mjb_" + _remove + "CBAHandlerVic"),nil]);
//systemChat "removing cba vic handler";
    _eventHandle call CBA_fnc_removeEventHandler;
    missionNamespace setVariable [("mjb_" + _remove + "CBAHandlerVic"), nil ];
};

if (!isNil ("mjb_" + _remove + "ACEAction") ) then {
    private _eventHandle = (missionNamespace getVariable [("mjb_" + _remove + "ACEAction"),nil]);
//systemChat "removing ace action";
    _eventHandle call ace_interact_menu_fnc_removeActionFromClass;
    missionNamespace setVariable [("mjb_" + _remove + "ACEAction"), nil ];
    //if (!isNil "mjb_storedWeapon") then {deleteVehicle (mjb_storedWeapon # 2); mjb_storedWeapon = nil;};
};

if (!isNil ("mjb_" + _remove + "Statemachine") ) then {
    private _eventHandle = (missionNamespace getVariable [("mjb_" + _remove + "Statemachine"),nil]);
    sleep 1;
//systemChat "removing Statemachine";
    _eventHandle call CBA_statemachine_fnc_delete;
    missionNamespace setVariable [("mjb_" + _remove + "Statemachine"), nil ];
};

mjb_activePerks = mjb_activePerks - [_remove];
// !!!!! _target setVariable ["mjb_activePerks", mjb_activePerks, [owner _target, 2]];
mjb_pP = mjb_pP + (missionNamespace getVariable [("mjb_" + _remove + "Points"),0]);