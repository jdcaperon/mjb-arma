/*
    * Arguments:

    ex.: call mjb_perks_fnc_perkSelect;
*/

if !(canSuspend) exitWith {_this spawn mjb_perks_fnc_perkSelect};
    waitUntil {!isNull player};
    sleep 1;

if !(didJIP) then {
};

//Variables
private _aceMedLoaded = isClass(configFile >> "CfgPatches" >> "ace_medical_engine"); //Store whether ace med is present

private _rejoincheck = player getVariable "startpos";
if (isNil "_rejoincheck") then {
    player setVariable ["startpos", getPosASL player, true];
};

mjb_activePerks = [];

private _event = "Killed";
mjb_deathCleanupHandler = [ _event, (player addEventHandler [_event, {[true] call mjb_perks_fnc_perkCleanup;}] ) ];

// main action
private _action =
[
    "perk_select","Perks","\A3\ui_f\data\igui\cfg\holdactions\holdAction_requestLeadership_ca.paa",
    {

    },
    {
        (player distance2d (player getVariable ["startpos",[0,0,0]])) < 200
    },
    {},
    [],
    [0,0,0],
    3,
    [false, true, false, false, true]
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

private _disableMod = {
    params ["_target", "_player", "_params", "_actionData"]; _params params ["_perkName"];
    private _perkCost = (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
    private _textName = _actionData select 1;
    if (_perkName in mjb_activePerks) then {
        _textName = ("Remove " + _textName);
    };
    _actionData set [1, format ["%1, %2", _textName, _perkCost] ];
};

// No Perk
    private _perkName = "noPerk";
    _action =
    [
        _perkName,"None","\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_deactivate_ca.paa",
        {   params ["_target", "_player", "_actionParams"];
            [true] call mjb_perks_fnc_perkCleanup;
        },
        {
            true
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true]
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "perkNameDesc","No perk effects",
            "",{},  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;

// Perk
/*if (mjb_perkNameEnabled) then {
    private _perkName = "perkName";
    _action =
    [
        _perkName,"Perk Name","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            private _event = "Killed";
            missionNamespace setVariable [("mjb_" + _perkName + "Handler"),
                ([ _event, (player addEventHandler [_event, { }] ) ])
            ];
            mjb_activePerks pushBack _perkName;
            mjb_perkPoints = mjb_perkPoints - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_perkNameEnabled && {mjb_perkPoints >= mjb_perkNamePoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "perkNameDesc","Perk Description",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};*/

if (mjb_packSlingEnabled) then {
    private _perkName = "packSling";
    _action =
    [
        _perkName,"Pack Sling","z\mjb\addons\perks\data\packSling_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            private _event = "Killed";
            missionNamespace setVariable [("mjb_pSlingHandler"),
                ([ _event, (player addEventHandler [_event, {
                    if (!isNil "mjb_storedWeapon") then {
                        (mjb_storedWeapon # 2) enableSimulationGlobal true;
                        mjb_storedWeapon = nil;
                    };
                    player removeEventHandler [_thisEvent,_thisEventHandler];
                }] ) ])
            ];
            private _pSling =
            [
                "pSling","Sling current weapon","z\mjb\addons\perks\data\packSling_ca.paa",
                {
                    call mjb_perks_fnc_pSling;
                },
                { true },
                {},[],[0,0,0],3,[false, false, false, false, true],
                {   params ["", "", "", "_actionData"];
                    if (!isNil "mjb_storedWeapon") then {
                        private _class = ((mjb_storedWeapon # 0) # 0);
                        private _weapon = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
                        _actionData set [1, ("Equip/Swap to: " + _weapon)];
                    };
                }
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf player;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _pSling] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_activePerks pushBack _perkName;
            mjb_perkPoints = mjb_perkPoints - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_packSlingEnabled && { mjb_perkPoints >= mjb_packSlingPoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "perkDesc","Store an extra weapon",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_plateDropEnabled) then {
    private _perkName = "plateDrop";
    _action =
    [
        _perkName,"Plate Drop","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\vest_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            //private _event = "Fired";
            //mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
            private _pDrop =
            [
                "pDrop","Plate Call-in","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\vest_ca.paa",
                {
                    private _target = player;
                    private _pCrate = "Box_Syndicate_Ammo_F" createVehicle (getPos _target);
                    private _height = 500;
                    if (getTerrainHeightASL (getPosATL _pCrate) <= 0) then {
                        _pCrate setPosASL [getPosASL _pCrate select 0, getPosASL _pCrate select 1, _height];
                    } else {
                        _pCrate setPosATL [getPosATL _pCrate select 0, getPosATL _pCrate select 1, _height];
                    };
                    clearItemCargoGlobal _pCrate;
                    clearMagazineCargoGlobal _pCrate;
                    clearWeaponCargoGlobal _pCrate;
                    clearBackpackCargoGlobal _pCrate;
                    _pCrate allowDamage false;
                    _pCrate addItemCargoGlobal ["diw_armor_plates_main_plate", 9];
                    _pCrate spawn { params ["_crate"];
                        while {(getPosATL _crate) # 2 > 1 && {(getPosASL _crate) # 2 > 3}} do {sleep 1;};
                        _crate setVelocity [0, 0, 0];
                    };
                    mjb_plateDropAvailable = false;
                    [{mjb_plateDropAvailable = true;}, [], 1200] call CBA_fnc_waitAndExecute;
                },
                { mjb_plateDropAvailable && { leader player == player || {player getUnitTrait 'Medic'}} },
                { },[],[0,0,0],3,[false, false, false, false, true]
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf player;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _pDrop] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_plateDropAvailable = true;
            mjb_activePerks pushBack _perkName;
            mjb_perkPoints = mjb_perkPoints - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_plateDropEnabled && { (leader player == player || {player getUnitTrait 'Medic'}) && { (mjb_perkPoints >= mjb_plateDropPoints || {_perkName in mjb_activePerks}) } }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "plateDropDesc","Req. Leader or Medic, Have a box of plates dropped in, 20 min. cooldown",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_sneakAttackEnabled) then {
    private _perkName = "sneakAttack";
    _action =
    [
        _perkName,"Sneak Attack","\A3\ui_f\data\igui\cfg\commandbar\combatMode_textureMStealth_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            //private _event = "Fired";
            private _playerHandler = ["ace_firedPlayer", { params["", "", "", "", "", "", "_projectile"];
                    [_projectile] call mjb_perks_fnc_sneakProjHandler;
                }] call CBA_fnc_addEventHandler;
            missionNamespace setVariable [("mjb_" + _perkName + "CBAHandler"),
                ["ace_firedPlayer", _playerHandler]
            ];

            private _vicHandler = ["ace_firedPlayerVehicle", { params["", "", "", "", "", "", "_projectile"];
                    [_projectile] call mjb_perks_fnc_sneakProjHandler;
                }] call CBA_fnc_addEventHandler;
            missionNamespace setVariable [("mjb_" + _perkName + "CBAHandlerVic"),
                ["ace_firedPlayerVehicle", _vicHandler]
            ];
            //mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
            mjb_activePerks pushBack _perkName;
            mjb_perkPoints = mjb_perkPoints - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_sneakAttackEnabled && {mjb_perkPoints >= mjb_sneakAttackPoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "sneakAttackDesc","Hits on enemies that aren't aware of you deal more damage.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_dragonEnabled) then {
    private _perkName = "dragon";
    _action =
    [
        _perkName,"Dragon's Breath","\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_fire_in_flame_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            //private _event = "Fired";
            private _playerHandler = ["ace_firedPlayer", { params["", "", "", "", "", "", "_projectile"];
                    [_projectile] call mjb_perks_fnc_dragonHandler;
                }] call CBA_fnc_addEventHandler;
            missionNamespace setVariable [("mjb_" + _perkName + "CBAHandler"),
                ["ace_firedPlayer", _playerHandler]
            ];
            //mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
            mjb_activePerks pushBack _perkName;
            mjb_perkPoints = mjb_perkPoints - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_dragonEnabled && {mjb_perkPoints >= mjb_dragonPoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "perkDesc","Buckshot is upgraded to have a chance to set targets on fire.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_telestickEnabled) then {
    private _perkName = "telestick";
    _action =
    [
        _perkName,"Telestick","\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_getin_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            //private _event = "Fired";
            private _playerHandler = ["ace_firedPlayer", { params["", "_weapon", "", "", "", "", "_projectile"];
                if (_weapon isNotEqualTo "Throw") exitWith {};
                private _projClass = (typeOf _projectile);
                if ("hemlight" in _projClass) then {
                    _projectile addEventHandler ["Explode", {
                        params ["","_pos"];
                        player setPosASL _pos;
                    }];
                };
            }] call CBA_fnc_addEventHandler;
            missionNamespace setVariable [("mjb_" + _perkName + "CBAHandler"),
                ["ace_firedPlayer", _playerHandler]
            ];
            mjb_activePerks pushBack _perkName;
            mjb_perkPoints = mjb_perkPoints - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_telestickEnabled && {mjb_perkPoints >= mjb_dragonPoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "perkDesc","Teleport to thrown chemlights.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_eyesEnabled) then {
    private _perkName = "eyes";
    _action =
    [
        _perkName,"Hawk eyes","z\mjb\addons\perks\data\mjbeyes.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            missionNamespace setVariable [("mjb_" + _perkName + "Loop"),
                [] spawn mjb_perks_fnc_eyesLoop
            ];
            //private _event = "Fired";
            //mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
            mjb_activePerks pushBack _perkName;
            mjb_perkPoints = mjb_perkPoints - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_eyesEnabled && {mjb_perkPoints >= mjb_eyesPoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        _action =
        [
            "perkDesc","Farther zoom while not aimed, risk of disembodiment.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};