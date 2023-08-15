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

private _rejoincheck = (player getVariable "startpos");
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
mjb_deathCleanupHandler = [ _event, (player addEventHandler [_event, {[true, (_this select 0)] call mjb_perks_fnc_perkCleanup;}] ) ];

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

private _mainPath = ["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

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
            [true, _target] call mjb_perks_fnc_perkCleanup;
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
    private _parent = ["CAManBase", 1, _mainPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"No perk effects",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;


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

private _catPath = ["CAManBase", 1, _mainPath, _action, true] call ace_interact_menu_fnc_addActionToClass;

// Perk
/*if (mjb_perkNameEnabled) then {
    private _perkName = "perkName";
    private _action =
    [
        _perkName,"Perk Name","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",
        mjb_perks_fnc_perkName,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Perk Description",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};*/

if (mjb_flashDoorEnabled) then {
    private _perkName = "flashDoor";
    private _action =
    [
        _perkName,"Doorkicker","z\mjb\addons\perks\data\flash_door_ca.paa",
        mjb_perks_fnc_flashDoor,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Self-interact at a door with flashbangs for a breach action.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_extraHpEnabled) then {
    private _perkName = "extraHp";
    private _action =
    [
        _perkName,"Extra Conditioning","\A3\ui_f\data\igui\cfg\actions\heal_ca.paa",
        mjb_perks_fnc_extraHp,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title, "",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true],
            {   params ["", "", "", "_actionData"];
                _actionData set [1, format ["%1%2 More max HP.", ((mjb_extraHpMult - 1) * 100), "%"]];
            }
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_plateDropEnabled) then {
    private _perkName = "plateDrop";
    private _action =
    [
        _perkName,"Plate Drop","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\vest_ca.paa",
        mjb_perks_fnc_plateDrop,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Req. Leader or Medic, Call a box of plates and FAKs in. (%1 sec)",mjb_plateDropCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_ammoDropEnabled) then {
    private _perkName = "ammoDrop";
    private _action =
    [
        _perkName,"Ammo Drop","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargoMagAll_ca.paa",
        mjb_perks_fnc_ammoDrop,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Req. Leader, Have an ammo arsenal box dropped in. (%1 sec)",mjb_ammoDropCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_telestickEnabled) then {
    private _perkName = "telestick";
    private _action =
    [
        _perkName,"Telestick","\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_getin_ca.paa",
        mjb_perks_fnc_telestick,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Teleport to thrown chemlights.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_heartEnabled) then {
    private _perkName = "heart";
    private _action =
    [
        _perkName,"Heartbeat Sensor","\A3\ui_f\data\igui\cfg\actions\RadarOn_ca.paa",
        mjb_perks_fnc_heart,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Detect units in a %1m radius centered %2m in front of you.",mjb_heartRange,mjb_heartCenter],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_plateUpEnabled) then {
    private _perkName = "plateUp";
    private _action =
    [
        _perkName,"Plate Up","\A3\ui_f\data\GUI\Cfg\Hints\Timing_ca.paa",
        mjb_perks_fnc_plateUp,
        { params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
            mjb_plateUpEnabled && {mjb_pP >= mjb_plateUpPoints || {_perkName in mjb_activePerks}}
        },
        { },
        [_perkName],
        [0,0,0],
        3,
        [false, true, false, false, true],
        _disableMod
    ] call ace_interact_menu_fnc_createAction;
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Plate regen starts immediately.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_eyesEnabled) then {
    private _perkName = "eyes";
    private _action =
    [
        _perkName,"Hawk eyes","z\mjb\addons\perks\data\mjbeyes.paa",
        mjb_perks_fnc_eyes,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Farther zoom while not aimed, risk of disembodiment.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
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

private _catPath = ["CAManBase", 1, _mainPath, _action, true] call ace_interact_menu_fnc_addActionToClass;


if (mjb_packSlingEnabled) then {
    private _perkName = "packSling";
    private _action =
    [
        _perkName,"Pack Sling","z\mjb\addons\perks\data\packSling_ca.paa",
        mjb_perks_fnc_packSling,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Store an extra weapon in a self-interact action.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_dragonEnabled) then {
    private _perkName = "dragon";
    private _action =
    [
        _perkName,"Dragon's Breath","\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_fire_in_flame_ca.paa",
        mjb_perks_fnc_dragon,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Buckshot is upgraded to have a chance to set targets on fire.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_randEnabled) then {
    private _perkName = "rand";
    private _action =
    [
        _perkName,"Bullet Lottery","z\mjb\addons\perks\data\rand_ca.paa",
        mjb_perks_fnc_rand,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Fire random projectiles.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_sneakAttackEnabled) then {
    private _perkName = "sneakAttack";
    private _action =
    [
        _perkName,"Sneak Attack","\A3\ui_f\data\igui\cfg\commandbar\combatMode_textureMStealth_ca.paa",
        mjb_perks_fnc_sneakAttack,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,"Hits on enemies that aren't aware of you deal more damage.",
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_disChargeEnabled) then {
    private _perkName = "disCharge";
    private _action =
    [
        _perkName,"Disposable Recharge","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\secondaryWeapon_ca.paa",
        mjb_perks_fnc_disCharge,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Disposables recharge after registered and slot empty. (%1 sec)",mjb_disChargeCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
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

private _catPath = ["CAManBase", 1, _mainPath, _action, true] call ace_interact_menu_fnc_addActionToClass;


if (mjb_techSuppEnabled) then {
    private _perkName = "techSupp";
    private _action =
    [
        _perkName,"Technical Support","\A3\ui_f\data\map\vehicleicons\iconStaticMG_ca.paa",
        mjb_perks_fnc_techSupp,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Summon a technical. Limit: 1 active in platoon. (%1 sec)",mjb_techSuppCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_familiarEnabled) then {
    private _perkName = "familiar";
    private _action =
    [
        _perkName,"Summon Familiar","\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa",
        mjb_perks_fnc_familiar,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Call in an AI vehicle for 3 min, set in settings. (%1 sec)",mjb_familiarCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_pitCrewEnabled) then {
    private _perkName = "pitCrew";
    private _action =
    [
        _perkName,"Pit Crew","\A3\ui_f\data\GUI\Cfg\Hints\Driving_ca.paa",
        mjb_perks_fnc_pitCrew,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Fix wheels/treads after a 15 sec delay. (%1 sec)",mjb_pitCrewCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_repairEnabled) then {
    private _perkName = "repair";
    private _action =
    [
        _perkName,"Emergency Repair","\A3\ui_f\data\GUI\Cfg\Hints\VehicleRepair_ca.paa",
        mjb_perks_fnc_repair,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Fix fuel tank, and partial repair functional systems. (%1 sec)",mjb_repairCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_rearmEnabled) then {
    private _perkName = "rearm";
    private _action =
    [
        _perkName,"Re-arm","\A3\ui_f\data\GUI\Cfg\Hints\VehicleAmmo_ca.paa",
        mjb_perks_fnc_rearm,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["Add more ammo for vic weapons. (%1 sec)",mjb_rearmCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_shieldEnabled) then {
    private _perkName = "shield";
    private _action =
    [
        _perkName,"Damage Shield","\A3\ui_f\data\GUI\Cfg\Hints\armor_era_ca.paa",
        mjb_perks_fnc_shield,
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
    private _parent = ["CAManBase", 1, _catPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
        // Perk description
		private _title = str (_perkName + "Desc");
        private _action =
        [
            _title,format ["10 seconds of invulnerability. (%1 sec)",mjb_shieldCd],
            "",{ },  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
        ] call ace_interact_menu_fnc_createAction;

        ["CAManBase", 1, _parent, _action, true] call ace_interact_menu_fnc_addActionToClass;
};