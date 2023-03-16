params ["_target"];

mjb_kickCD = true;
    private _condition = {
        mjb_kickCD && {(([2.5] call ace_interaction_fnc_getDoor) select 1) isNotEqualTo ""}
    };
    private _statement = {
        private _mags = magazines player;
        private _flash = ["ACE_M84","ACE_CTS9"];
        private _noFlash = _flash;
        {
            if (_x in _mags) exitWith {_flash = _x};
        } forEach _flash;
        if (_flash isEqualTo _noFlash) exitWith {systemChat "No ACE flashbangs available."};
        private _info = [2.5] call ace_interaction_fnc_getDoor;
        _info params ["_house", "_door"];
if ((configProperties [configOf _house >> "UserActions"]) isEqualTo []) exitWith {
};
        if (_door isEqualTo "") exitWith {systemChat "Door failed."};

private _getDoorAnimations = [_house, _door] call ace_interaction_fnc_getDoorAnimations;
_getDoorAnimations params ["_animations"];
if (_animations isEqualTo []) exitWith {systemChat "No usable door."};
private _lockedVariable = format ["bis_disabled_%1", _door];
if ((_house animationPhase (_animations select 0) <= 0) && {_house getVariable [_lockedVariable, 0] == 1}) exitWith {
    private _lockedAnimation = format ["%1_locked_source", _door];
    if (isClass (configOf _house >> "AnimationSources" >> _lockedAnimation)) then {
        // from: a3\structures_f\scripts\fn_door.sqf: - wiggles the door handle (A3 buildings)
        _house animateSource [_lockedAnimation, (1 - (_house animationSourcePhase _lockedAnimation))];
    };
};
if (typeOf _house == "Land_Carrier_01_island_01_F") then {
    private _handle = format ["door_handle_%1_rotate_1", (_animations select 0) select [5, 1]];
    _animations pushBack _handle;
};
if (_house animationPhase (_animations select 0) > 0.4) exitWith { systemChat "Door already open."};
private _flashObj = ["ACE_G_M84","ACE_G_CTS9"] select (_noFlash find _flash);
player removeItem _flash;
private _count = ({_x == _flash} count uniformItems player) + ({_x == _flash} count vestItems player) + ({_x == _flash} count backpackItems player);

[_flash, _count] call ace_weaponselect_fnc_displayGrenadeTypeAndNumber;
_flashObj = _flashObj createVehicle [0,0,0];
private _place = AGLToASL (positionCameraToWorld [0,0,3]);
            {_house animate [_x, 0.2];} forEach _animations;
       [{params ["_house","_animations"];
            {_house animate [_x, 0];} forEach _animations;
        }, [_house, _animations], 0.3] call CBA_fnc_waitAndExecute;
_flashObj setPosASL _place;
       [{
            private _curAnim = animationState player;
            player switchMove "wbk_fists_attack_leg";
           [{params["_reset"]; if (_reset isEqualTo "wbk_fists_attack_leg") then {_reset = ""}; player switchMove _reset}, [_curAnim], 1] call CBA_fnc_waitAndExecute;
        }, [], 0.69] call CBA_fnc_waitAndExecute;
       [{params ["_detonate", "_house","_animations"]; [_detonate] call ace_grenades_fnc_flashbangThrownFuze;
            {_house animate [_x, 1];} forEach _animations;
        }, [_flashObj, _house, _animations], 1] call CBA_fnc_waitAndExecute;
        mjb_kickCD = false;
        [{mjb_kickCD = true;}, [], 20] call CBA_fnc_waitAndExecute;
    };
    private _action = ["doorKick","Flash and Kick","z\mjb\addons\perks\data\flash_door_ca.paa",_statement,_condition, { }, [], [0,0,0], 3, [true, false, false, false, true]] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

[_addClass, 1, _path]