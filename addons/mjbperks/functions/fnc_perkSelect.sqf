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
    private _action =
    [
        _perkName,"Clear Perks","\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_deactivate_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
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
        private _action =
        [
            (_perkName + "Desc"),"No perk effects",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;


private _perkCat = "playerPerk_select";
private _action =
[
    _perkCat,"Player Perks","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\insignia_ca.paa",
    {

    },
    {
        true
    },
    {},
    [],
    [0,0,0],
    3,
    [false, true, false, false, true], {
        params ["", "", "", "_actionData"];
        //_actionData set [1, format ["%1, pts: %2", "Player Perks", mjb_pP]];
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;

// Perk
/*if (mjb_perkNameEnabled) then {
    private _perkName = "perkName";
    private _action =
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),"Perk Description",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};*/

if (mjb_flashDoorEnabled) then {
    private _perkName = "flashDoor";
    private _action =
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
    private _perkName = "flashDoor";
        private _action =
        [
            (_perkName + "Desc"),"Self-interact at a door with flashbangs for a breach action.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_extraHpEnabled) then {
    private _perkName = "extraHp";
    private _action =
    [
        _perkName,"Extra Conditioning","\A3\ui_f\data\igui\cfg\actions\heal_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {
                private _newHP = mjb_defaultHP;
                mjb_defaultHP = nil;
                _target setVariable ["diw_armor_plates_main_maxHp", _newHP, true];
                [_target, _newHP] spawn {params ["_target","_newHP"]; sleep 1; _target setVariable ["diw_armor_plates_main_hp", (_newHP + 0.001), true]; [player] call diw_armor_plates_main_fnc_updateHPUi;};
                _target call diw_armor_plates_main_fnc_fillVestWithPlates;
                [player] call diw_armor_plates_main_fnc_updatePlateUi;
                [_perkName] call mjb_perks_fnc_perkCleanup;
            };
            // perk effects
            mjb_defaultHP = _target getVariable ["diw_armor_plates_main_maxHp", diw_armor_plates_main_maxPlayerHP];
            private _newHP = (ceil (mjb_defaultHP * mjb_extraHpMult));
            _target setVariable ["diw_armor_plates_main_maxHp", _newHP, true];
            _target setVariable ["diw_armor_plates_main_hp", (_newHP + 0.001), true];
            [player] call diw_armor_plates_main_fnc_updateHPUi;
            _target call diw_armor_plates_main_fnc_fillVestWithPlates;
            [player] call diw_armor_plates_main_fnc_updatePlateUi;
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"), "",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true],
            {   params ["", "", "", "_actionData"];
                _actionData set [1, format ["%1%2 More max HP.", ((mjb_extraHpMult - 1) * 100), "%"]];
            }
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_plateDropEnabled) then {
    private _perkName = "plateDrop";
    private _action =
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
                    _pCrate addItemCargoGlobal ["FirstAidKit", 9];
                    if ((_target getUnitTrait 'Medic') && {(mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors}) then {
                        _pCrate addItemCargoGlobal ["diw_armor_plates_main_autoInjector", 1];
                        mjb_arsenal_injectorStash = mjb_arsenal_injectorStash + 1;
                    };
                    _pCrate spawn { params ["_crate"];
                        while {(getPosATL _crate) # 2 > 1 && {(getPosASL _crate) # 2 > 3}} do {sleep 1;};
                        _crate setVelocity [0, 0, 0];
                    };
                    mjb_plateDropAvailable = false;
                    [{mjb_plateDropAvailable}, {mjb_plateDropAvailable = true;}, [], mjb_plateDropCd, {mjb_plateDropAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
                },
                {    params ["_target"]; mjb_plateDropAvailable && { leader _target isEqualTo _target || {_target getUnitTrait 'Medic'}} },
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
            mjb_plateDropEnabled && { (leader _target isEqualTo _target || {_target getUnitTrait 'Medic'}) && { (mjb_pP >= mjb_plateDropPoints || {_perkName in mjb_activePerks}) } }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Req. Leader or Medic, Call a box of plates and FAKs in. (%1 sec)",mjb_plateDropCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_ammoDropEnabled) then {
    private _perkName = "ammoDrop";
    private _action =
    [
        _perkName,"Ammo Drop","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargoMagAll_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            //private _event = "Fired";
            //mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
            private _aDrop =
            [
                "aDrop","Ammo Call-in","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargoMagAll_ca.paa",
                {   params ["_target"];
                    private _pCrate = "Box_Rats_Ammo" createVehicle (getPos _target);
                    private _height = 500;
                    if (getTerrainHeightASL (getPosATL _pCrate) <= 0) then {
                        _pCrate setPosASL [getPosASL _pCrate select 0, getPosASL _pCrate select 1, _height];
                    } else {
                        _pCrate setPosATL [getPosATL _pCrate select 0, getPosATL _pCrate select 1, _height];
                    };
                    _pCrate allowDamage false;
                    _pCrate spawn { params ["_crate"];
                        while {(getPosATL _crate) # 2 > 1 && {(getPosASL _crate) # 2 > 3}} do {sleep 1;};
                        _crate setVelocity [0, 0, 0];
                        [_crate, false] remoteExec ["ace_dragging_fnc_setDraggable",0];
                        [_crate, false] remoteExec ["ace_dragging_fnc_setCarryable",0];
                        [_crate, 10] remoteExec ["ace_cargo_fnc_setSize",0];
                        [_crate, true] remoteExec ["allowDamage", _crate];
                        //mjb_ammoCalled = _crate;
                        [_crate, { params ["_crate"];
                            _crate addEventHandler ["Killed", {
                                params ["_unit"];
                                clearItemCargoGlobal _unit;
                                clearWeaponCargoGlobal _unit;
                                clearBackpackCargoGlobal _unit;
                                [_unit, true] call ace_arsenal_fnc_removeBox;
                        }];}] remoteExec ["call", 2];
                    };
                    mjb_ammoDropAvailable = false;
                    [{mjb_ammoDropAvailable}, {mjb_ammoDropAvailable = true;}, [], mjb_ammoDropCd, {mjb_ammoDropAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
                },
                {   params ["_target"]; mjb_ammoDropAvailable && { leader _target isEqualTo _target } },
                { },[],[0,0,0],3,[false, false, false, false, true]
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf _target;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_ammoDropAvailable = true;
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_ammoDropEnabled && { (leader _target isEqualTo _target) && { (mjb_pP >= mjb_ammoDropPoints || {_perkName in mjb_activePerks}) } }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Req. Leader, Have an ammo arsenal box dropped in. (%1 sec)",mjb_ammoDropCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_sneakAttackEnabled) then {
    private _perkName = "sneakAttack";
    private _action =
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),"Hits on enemies that aren't aware of you deal more damage.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_telestickEnabled) then {
    private _perkName = "telestick";
    private _action =
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),"Teleport to thrown chemlights.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_heartEnabled) then {
    private _perkName = "heart";
    private _action =
    [
        _perkName,"Heartbeat Sensor","\A3\ui_f\data\igui\cfg\actions\RadarOn_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            missionNamespace setVariable [("mjb_" + _perkName + "Loop"),
                [] spawn mjb_perks_fnc_heartLoop
            ];
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_heartEnabled && {mjb_pP >= mjb_heartPoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Detect units outside your group within a %1m radius on DUI radar.",mjb_heartRange],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_eyesEnabled) then {
    private _perkName = "eyes";
    private _action =
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),"Farther zoom while not aimed, risk of disembodiment.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

// Weapon Perks
private _perkCat = "weaponPerk_select";
private _action =
[
    _perkCat,"Weapon Perks","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\spaceArsenal_ca.paa",
    {

    },
    {
        true
    },
    {},
    [],
    [0,0,0],
    3,
    [false, true, false, false, true], {
        params ["", "", "", "_actionData"];
        //_actionData set [1, format ["%1, pts: %2", "Weapon Perks", mjb_pP]];
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;


if (mjb_packSlingEnabled) then {
    private _perkName = "packSling";
    private _action =
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
                        if ((mjb_storedWeapon # 1) < 0) exitWith {
                            private _class = typeOf (mjb_storedWeapon # 0);
                            private _weapon = getText (configFile >> "CfgVehicles" >> _class >> "displayName");
                            _actionData set [1, ("Equip/Swap to: " + _weapon)];
                        };
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),"Store an extra weapon in a self-interact action.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_dragonEnabled) then {
    private _perkName = "dragon";
    private _action =
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
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),"Buckshot is upgraded to have a chance to set targets on fire.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_randEnabled) then {
    private _perkName = "rand";
    private _action =
    [
        _perkName,"Bullet Lottery","z\mjb\addons\perks\data\rand_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            // perk effects
            //mjb_activePerkLoop = [] spawn {};
            //private _event = "Fired";
            private _playerHandler = ["ace_firedPlayer", { params["", "_weapon", "", "", "", "", "_projectile"];
                    _projectile addEventHandler ["SubmunitionCreated", {
                        params ["","_submunitionProjectile"];
                        [_submunitionProjectile] spawn mjb_perks_fnc_randHandler;
                    }];
                    if (_weapon isEqualTo "Throw") exitWith {};
                    [_projectile] spawn mjb_perks_fnc_randHandler;
                }] call CBA_fnc_addEventHandler;
            missionNamespace setVariable [("mjb_" + _perkName + "CBAHandler"),
                ["ace_firedPlayer", _playerHandler]
            ];
            //mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_randEnabled && {mjb_pP >= mjb_randPoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),"Fire random projectiles.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_disChargeEnabled) then {
    private _perkName = "disCharge";
    private _action =
    [
        _perkName,"Disposable Recharge","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\secondaryWeapon_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {mjb_disChargeCdDone = nil; mjb_regDisposable = nil; [_perkName] call mjb_perks_fnc_perkCleanup;};
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
            mjb_regDisposable = ["",""];
            private _disSling =
            [
                "disSling","Register Disposable","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\secondaryWeapon_ca.paa",
                { params ["_target"];
                    private _rocket = secondaryWeaponMagazine _target;
                    if (_rocket isEqualTo []) then {_rocket = [""];};
                    mjb_regDisposable = [secondaryWeapon _target, (_rocket # 0)];
                    private _remove = "disCharge";
                    private _perkName = "disCharge";
                    if (!isNil ("mjb_" + _remove + "Statemachine") ) then {
                        private _eventHandle = (missionNamespace getVariable [("mjb_" + _remove + "Statemachine"),nil]);
                        _eventHandle call CBA_statemachine_fnc_delete;
                        missionNamespace setVariable [("mjb_" + _remove + "Statemachine"), nil ];
                    };
                    private _stateMachine = [configFile >> "MJB_Perks" >> "mjb_perks_disChargeState"] call CBA_statemachine_fnc_createFromConfig;
                    missionNamespace setVariable [("mjb_" + _perkName + "Statemachine"),
                        [_stateMachine]
                    ];
                },
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
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_disChargeEnabled && { mjb_pP >= mjb_disChargePoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Disposables recharge after registered and slot empty. (%1 sec)",mjb_disChargeCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

// register disposables,
// CfgWeapons >> _weapClass >> rhs_disposable = 1;
// CfgWeapons >> _weapClass >> EventHandlers >> fired = "_this call CBA_fnc_firedDisposable";
// CfgWeapons >> _weapClass >> displayName = "FIM-92F Stinger (Used)"; // if contains Used replace with new launcher


// Vic Perks// main action
private _perkCat = "vicperk_select";
private _action =
[
    _perkCat,"Vehicle Perks","\A3\ui_f\data\map\vehicleicons\iconAPC_ca.paa",
    {

    },
    {
        true
    },
    {},
    [],
    [0,0,0],
    3,
    [false, true, false, false, true], {
        params ["", "", "", "_actionData"];
        //_actionData set [1, format ["%1, pts: %2", "Vehicle Perks", mjb_pP]];
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","perk_select"], _action, true] call ace_interact_menu_fnc_addActionToClass;


if (mjb_techSuppEnabled) then {
    private _perkName = "techSupp";
    private _action =
    [
        _perkName,"Technical Support","\A3\ui_f\data\map\vehicleicons\iconStaticMG_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
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
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_techSuppEnabled && { mjb_pP >= mjb_techSuppPoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Summon a technical. Limit: 1 active in platoon. (%1 sec)",mjb_techSuppCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_familiarEnabled) then {
    private _perkName = "familiar";
    private _action =
    [
        _perkName,"Summon Familiar","\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            private _aDrop =
            [
                "familiar","Summon Familiar","\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa",
                {   params ["_target"];
                    private _pos = ([getPos _target, 6, 20, 6, 0, 0.5, 0] call BIS_fnc_findSafePos);
                    if (_pos isEqualTo []) exitWith {systemChat "Suitable summon position not found."};
                    private _vicClass = ["CUP_B_Leopard2A6_HIL","CUP_B_M6LineBacker_NATO_T"] select mjb_perks_familiar;
                    private _vic = ([_pos, getDir _target, _vicClass, group _target] call BIS_fnc_spawnVehicle);
                    private _crew = (_vic select 1);
                    _vic = (_vic select 0);
                    [[_vic, _crew], {  params ["_vic", "_crew"];
                        _vic enableSimulationGlobal false;
                        _vic lockCargo true;
                        _vic lock true;
                        clearItemCargoGlobal _vic;
                        clearMagazineCargoGlobal _vic;
                        clearWeaponCargoGlobal _vic;
                        clearBackpackCargoGlobal _vic;
                        if ((typeOf _vic) isEqualTo "CUP_B_M6LineBacker_NATO_T") then {_vic lockCargo false;
                            [_vic, "RATS"] call BIS_fnc_initVehicle;
                            _vic addWeaponCargoGlobal ["mjb_arifle_C7Alpha", 14];
                            _vic addMagazineCargoGlobal ["CUP_30Rnd_556x45_Emag", 28];
                            _vic addMagazineCargoGlobal ["CUP_30Rnd_556x45_Emag_Tracer_Yellow", 28];
                        };
                        _vic enableSimulationGlobal true;
                        [{  params ["_vic","_crew"];
                            [[_vic,_crew], {  params ["_vic","_crew"];
                                {[_x] remoteExec ["deleteVehicle", _x]; waitUntil {_x isEqualTo objNull};} forEach _crew;
                                deleteVehicle _vic;
                            }] remoteExec ["spawn", _vic];
                        }, [_vic, _crew], 180] call CBA_fnc_waitAndExecute;
                    }] remoteExec ["call",2];
                    mjb_activeFamiliar = _vic;
                    mjb_familiarAvailable = false;
                    [{mjb_familiarAvailable}, {mjb_familiarAvailable = true;}, [], mjb_familiarCd, {mjb_familiarAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
                },
                { mjb_familiarAvailable  && {!(alive mjb_activeFamiliar)}},
                { },[],[0,0,0],3,[false, false, false, false, true]
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf _target;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_familiarAvailable = true;
            mjb_activeFamiliar = objNull;
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_familiarEnabled && { mjb_pP >= mjb_familiarPoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Call in an AI vehicle for 3 min, set in settings. (%1 sec)",mjb_familiarCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_pitCrewEnabled) then {
    private _perkName = "pitCrew";
    private _action =
    [
        _perkName,"Pit Crew","\A3\ui_f\data\GUI\Cfg\Hints\Driving_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
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
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_pitCrewEnabled && { mjb_pP >= mjb_pitCrewPoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Fix wheels/treads after a 15 sec delay. (%1 sec)",mjb_pitCrewCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_repairEnabled) then {
    private _perkName = "repair";
    private _action =
    [
        _perkName,"Emergency Repair","\A3\ui_f\data\GUI\Cfg\Hints\VehicleRepair_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            private _aDrop =
            [
                "mjb_repair","Emergency Repair","\A3\ui_f\data\GUI\Cfg\Hints\VehicleRepair_ca.paa",
                {   params ["_target"];
                    private _vic = vehicle _target;
                    _vic setHitPointDamage ["hitfuel",0];
                    private _damage = getAllHitPointsDamage _vic;
                    private _hitpoints = (_damage select 0);
                    _damage = (_damage select 2);
                    private _index = -1;
                    {
                        _index = _index + 1;
                        private _oldDamage = (_damage select _index);
                        if (_oldDamage >= 0.9) then {continue};
                        _newDamage = (_oldDamage - 0.2) max 0;
                        _vic setHitPointDamage [_x,_newDamage];

                    } forEach _hitpoints;
                    mjb_repairAvailable = false;
                    [{mjb_repairAvailable}, {mjb_repairAvailable = true;}, [], mjb_repairCd, {mjb_repairAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
                },
                { params ["_target"]; mjb_repairAvailable && {(vehicle _target) isNotEqualTo _target} },
                { },[],[0,0,0],3,[false, true, false, false, true]
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf _target;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_repairAvailable = true;
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_repairEnabled && { mjb_pP >= mjb_repairPoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Fix fuel tank, and partial repair functional systems. (%1 sec)",mjb_repairCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_rearmEnabled) then {
    private _perkName = "rearm";
    private _action =
    [
        _perkName,"Re-arm","\A3\ui_f\data\GUI\Cfg\Hints\VehicleAmmo_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            private _aDrop =
            [
                "mjb_rearm","Re-arm","\A3\ui_f\data\GUI\Cfg\Hints\VehicleAmmo_ca.paa",
                {   params ["_target"];
                    private _vic = vehicle _target;
                    [_vic, { params ["_vic"];
                        private _turrets = [[-1]] + (allTurrets [_vic, false]);
                        //for each turret, add 50% of (default load - remaining)
                        {
                            private _turret = _x;
                          [[_vic, _turret], { params ["_vic", "_turret"];
                            private _mags = _vic magazinesTurret [_turret, true];
                            private _magsEmpty = (_mags - (_vic magazinesTurret [_turret, false]));
                            while {_mags isNotEqualTo []} do {
                                private _magClass = (_mags select 0);
                                private _total = ({_x isEqualTo _magClass} count _mags);
                                private _empty = ({_x isEqualTo _magClass} count _magsEmpty);
                                private _reload = ((_total - (ceil (_empty / 2))) max 1);
                                private _extra = _total - _reload;
                                _vic removeMagazinesTurret [_magClass, _turret];
                                for "_i" from 1 to _reload do {_vic addMagazineTurret [_magClass, _turret];};
                                for "_i" from 1 to _extra do {_vic addMagazineTurret [_magClass, _turret, 0];};
                                for "_i" from 1 to _total do {
                                    private _delete = (_mags findIf {_x isEqualTo _magClass});
                                    if (_delete > -1) then {_mags deleteAt _delete;};
                                };
                                for "_i" from 1 to _empty do {
                                    private _delete = (_magsEmpty findIf {_x isEqualTo _magClass});
                                    if (_delete > -1) then {_magsEmpty deleteAt _delete;};
                                };
                            };
                                private _mags = _vic magazinesTurret [_turret, false];
                                {
                                    private _curgun = _x;
                                    { _vic loadMagazine [_turret, _curgun, _x];
                                        if (((weaponState [_vic,_turret,_curgun]) select 6) > 0) exitWith {};
                                    } forEach _mags;
                                } forEach (_vic weaponsTurret _turret);
                            }] remoteExec ["call", (_vic turretOwner _turret)];
                        } forEach _turrets;
                    }] remoteExec ["call", 2];
                    mjb_rearmAvailable = false;
                    [{mjb_rearmAvailable}, {mjb_rearmAvailable = true;}, [], mjb_rearmCd, {mjb_rearmAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
                },
                { params ["_target"]; mjb_rearmAvailable && {(vehicle _target) isNotEqualTo _target} },
                { },[],[0,0,0],3,[false, true, false, false, true]
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf _target;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_rearmAvailable = true;
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_rearmEnabled && { mjb_pP >= mjb_rearmPoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["Add more ammo for vic weapons. (%1 sec)",mjb_rearmCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_shieldEnabled) then {
    private _perkName = "shield";
    private _action =
    [
        _perkName,"Damage Shield","\A3\ui_f\data\GUI\Cfg\Hints\armor_era_ca.paa",
        {   params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            if (_perkName in mjb_activePerks) exitWith {[_perkName] call mjb_perks_fnc_perkCleanup;};
            private _aDrop =
            [
                "shield","Damage Shield","\A3\ui_f\data\GUI\Cfg\Hints\armor_era_ca.paa",
                {   params ["_target"];
                    private _vic = vehicle _target;
                    [_vic, false] remoteExec ["allowDamage", _vic];
                    [{ params ["_vic"];
                        [_vic, true] remoteExec ["allowDamage", _vic];
                    }, [_vic], 10] call CBA_fnc_waitAndExecute;
                    mjb_shieldAvailable = false;
                    [{mjb_shieldAvailable}, {mjb_shieldAvailable = true;}, [], mjb_shieldCd, {mjb_shieldAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
                },
                { params ["_target"]; mjb_shieldAvailable },
                { },[],[0,0,0],3,[false, true, false, false, true]
            ] call ace_interact_menu_fnc_createAction;
            private _addClass = typeOf _target;
            private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
            missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
                [_addClass, 1, _path]
            ];
            mjb_shieldAvailable = true;
            [_perkName] call mjb_perks_fnc_updatePerks;
        },
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_shieldEnabled && { mjb_pP >= mjb_shieldPoints || {_perkName in mjb_activePerks} }
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat], _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
        private _action =
        [
            (_perkName + "Desc"),format ["10 seconds of invulnerability. (%1 sec)",mjb_shieldCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, ["ACE_SelfActions","perk_select",_perkCat,_perkName], _action, true] call ace_interact_menu_fnc_addActionToClass;
};