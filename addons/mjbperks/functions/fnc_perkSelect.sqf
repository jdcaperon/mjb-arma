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
mjb_pP = mjb_perkPoints;
/*
    Perks saved to Profile and automatically loaded at missions starts? Checking point vals before applying
    save sling weapon

mjb_perkLoadName = getText (missionConfigFile >> "missionGroup");
if (mjb_perkLoadName isEqualTo "") then {mjb_perkLoadName = "mjb_loadout" + missionName;
} else {mjb_perkLoadName = "mjb_loadout" + mjb_perkLoadName};
private _varName = mjb_perkLoadName;
if (!isNil "mjb_perkLoadName") then {};
*/

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
    [false, true, false, false, true], {
        params ["", "", "", "_actionData"];
        _actionData set [1, format ["%1, pts: %2", "Perks", mjb_pP]];
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

private _disableMod = {
    params ["_target", "_player", "_params", "_actionData"]; _params params ["_perkName"];
    private _perkCost = (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
    private _textName = _actionData select 1;
    if (_perkName in mjb_activePerks) exitWith {
        _actionData set [1, format ["Remove %1, +%2", _textName, _perkCost] ];
    };
    _actionData set [1, format ["%1, %2", _textName, _perkCost] ];
};

// !!!!! _target setVariable ["mjb_activePerks", mjb_activePerks, [owner _target, 2]];

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
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_perkNameEnabled && {mjb_pP >= mjb_perkNamePoints || {_perkName in mjb_activePerks}}
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
            private _pSling =
            [
                "pSling","Sling current weapon","z\mjb\addons\perks\data\packSling_ca.paa",
                { params ["_target"];
                   [_target] call mjb_perks_fnc_pSling;
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
            private _stateMachine = [configFile >> "MJB_Perks" >> "mjb_perks_slingState"] call CBA_statemachine_fnc_createFromConfig;
            missionNamespace setVariable [("mjb_" + _perkName + "Statemachine"),
                [_stateMachine]
            ];
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_packSlingEnabled && { mjb_pP >= mjb_packSlingPoints || {_perkName in mjb_activePerks} }
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

if (mjb_flashDoorEnabled) then {
    private _perkName = "flashDoor";
    _action =
    [
        _perkName,"Doorkicker","z\mjb\addons\perks\data\flash_door_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_target] call mjb_perks_fnc_flashDoor
            ];
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_flashDoorEnabled && { mjb_pP >= mjb_flashDoorPoints || {_perkName in mjb_activePerks} }
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
            "perkDesc","Allows use of flash and kick, self-interact at a door with ace flashes.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_extraHpEnabled) then {
    private _perkName = "extraHp";
    _action =
    [
        _perkName,"Extra Conditioning","\A3\ui_f\data\igui\cfg\actions\heal_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {
                private _newHP = mjb_defaultHP;
                mjb_defaultHP = nil;
                _target setVariable ["diw_armor_plates_main_maxHp", _newHP, true];
                _target setVariable ["diw_armor_plates_main_Hp", (_newHP + 0.001), true];
                player call diw_armor_plates_main_fnc_updateHPUi;
                _target call diw_armor_plates_main_fnc_fillVestWithPlates;
                player call diw_armor_plates_main_fnc_updatePlateUi;
                [_perkName] call mjb_perks_fnc_perkCleanup;
            };
            // perk effects
            mjb_defaultHP = _target getVariable ["diw_armor_plates_main_maxHp", diw_armor_plates_main_maxPlayerHP];
            private _newHP = (ceil (mjb_defaultHP * mjb_extraHpMult));
            _target setVariable ["diw_armor_plates_main_maxHp", _newHP, true];
            _target setVariable ["diw_armor_plates_main_Hp", (_newHP + 0.001), true];
            player call diw_armor_plates_main_fnc_updateHPUi;
            _target call diw_armor_plates_main_fnc_fillVestWithPlates;
            player call diw_armor_plates_main_fnc_updatePlateUi;
            //private _event = "Fired";
            //mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_extraHpEnabled && {mjb_pP >= mjb_extraHpPoints || {_perkName in mjb_activePerks}}
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
            "perkDesc", "",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true],
            {   params ["", "", "", "_actionData"];
                _actionData set [1, format ["%1%2 More max HP.", ((mjb_extraHpMult - 1) * 100), "%"]];
            }
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
                {   params ["_target"];
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
                {    params ["_target"]; mjb_plateDropAvailable && { leader _target == _target || {_target getUnitTrait 'Medic'}} },
                { },[],[0,0,0],3,[false, false, false, false, true]
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf _target;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _pDrop] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_plateDropAvailable = true;
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_plateDropEnabled && { (leader _target == _target || {_target getUnitTrait 'Medic'}) && { (mjb_pP >= mjb_plateDropPoints || {_perkName in mjb_activePerks}) } }
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
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_sneakAttackEnabled && {mjb_pP >= mjb_sneakAttackPoints || {_perkName in mjb_activePerks}}
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
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_dragonEnabled && {mjb_pP >= mjb_dragonPoints || {_perkName in mjb_activePerks}}
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
            private _playerHandler = ["ace_firedPlayer", { params["_unit", "_weapon", "", "", "", "", "_projectile"];
                [_unit,_weapon,_projectile] call mjb_perks_fnc_telestickHandler;
            }] call CBA_fnc_addEventHandler;
            missionNamespace setVariable [("mjb_" + _perkName + "CBAHandler"),
                ["ace_firedPlayer", _playerHandler]
            ];
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_telestickEnabled && {mjb_pP >= mjb_telestickPoints || {_perkName in mjb_activePerks}}
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
            private _event = "OpticsSwitch";
            mjb_activePerkHandler = [ _event, (this addEventHandler [_event, {
                params ["_unit", "_isADS"];
                if (vehicle _unit isNotEqualTo _unit) exitWith {};
                mjb_aiming = _isADS;
            }] ) ];
            mjb_aiming = false;
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_eyesEnabled && {mjb_pP >= mjb_eyesPoints || {_perkName in mjb_activePerks}}
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



if (mjb_enableFlags) then {
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
    [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;

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
    [(typeOf player), 1, ["ACE_SelfActions","ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
};