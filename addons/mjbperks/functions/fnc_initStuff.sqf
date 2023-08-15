if (isNil "ace_interact_menu") exitWith {};
if (!isNil "mjb_perksInit") exitWith {};
mjb_perksInit = true;
if (!isDedicated && {mjb_perks}) then {
    call mjb_perks_fnc_perkSelect;
};


if (mjb_enableFlags) then {
    private _condition = {
        true
    };
    private _flag = "\A3\ui_f\data\igui\cfg\actions\takeflag_ca.paa";
    private _statement = { };
    private _action = ["ratsFlags","Flags",_flag,_statement,_condition, { }, [_flag], [0,0,0], 3, [false, true, false, false, true]] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    private _condition = {
        true
    };
    private _flag = "z\mjb\addons\flags\data\canadaflag_ca.paa";
    private _statement = { params ["_target", "_player", "_actionParams"]; _actionParams params ["_flag"];
        if (getForcedFlagTexture _target isEqualTo _flag) exitWith {[_target,""] remoteExec ["forceFlagTexture",0];};
        [_target,_flag] remoteExec ["forceFlagTexture",0];
    };
    private _disableMod = {
        params ["_target", "_player", "_params", "_actionData"]; _params params ["_flag"];
        if ((getForcedFlagTexture _target) isEqualTo _flag) then {
            _actionData set [1, "Remove Canadian Flag"];
        };
    };
    private _action = ["ratsFlag","Attach Canadian Flag",_flag,_statement,_condition, { }, [_flag], [0,0,0], 3, [false, true, false, false, true], _disableMod] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment","ratsFlags"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    private _condition = {
        true
    };
    private _flag = "z\mjb\addons\flags\data\ratsflag_ca.paa";
    private _statement = { params ["_target", "_player", "_actionParams"]; _actionParams params ["_flag"];
        if (getForcedFlagTexture _target isEqualTo _flag) exitWith {[_target,""] remoteExec ["forceFlagTexture",0];};
        [_target,_flag] remoteExec ["forceFlagTexture",0];
    };
    private _disableMod = {
        params ["_target", "_player", "_params", "_actionData"]; _params params ["_flag"];
        if ((getForcedFlagTexture _target) isEqualTo _flag) then {
            _actionData set [1, "Remove RATS Flag"];
        };
    };
    private _action = ["ratsFlag","Attach RATS Flag",_flag,_statement,_condition, { }, [_flag], [0,0,0], 3, [false, true, false, false, true], _disableMod] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment","ratsFlags"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

private _condition = {
    params ["", "_player"];
    private _curState = lifeState _player;
    (_curState isNotEqualTo "INCAPACITATED" || {_curState isEqualTo "INCAPACITATED" && {incapacitatedState _player isNotEqualTo "UNCONSCIOUS"}})
};
private _statement = {
params ["_target", "_player", "_params", "_actionData"];
if (_target getVariable ["ACE_isUnconscious", false]) exitWith {_target setVariable ["ACE_isUnconscious", false, true];};
    _target setVariable ["ACE_isUnconscious", true, true];
};
private _disableMod = {
    params ["_target", "_player", "_params", "_actionData"];
    if (_target getVariable ["ACE_isUnconscious", false]) then {
        _actionData set [1, "Disable AFK, disallow ace carry"];
    };
};
private _action = ["ratsAFK","AFK, allow ace carry","",_statement,_condition, { }, [], [0,0,0], 3, [false, true, false, false, true], _disableMod] call ace_interact_menu_fnc_createAction;
["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;