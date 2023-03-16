#include "settings.sqf"

if (isServer && {mjb_slotSaverAI}) then {
    addMissionEventHandler ["HandleDisconnect", {
        params ["_unit","_id","_uid"];
        private _savedId = _unit getVariable ["mjb_steamIDrop",true];
        if (_savedId isEqualTo _uid || {_savedId}) then {
            _unit setVariable ["mjb_steamIDrop",_uid];
            _unit addEventHandler ["Local", {
                params ["_player"];
                if (isServer) exitWith {
                    //_player setVariable ["mjb_startpos", (_player getVariable ["mjb_startpos", getPosASL player])];
                };
                if (_player getVariable ["mjb_steamIDrop",true] isEqualTo (getPlayerUID player)) exitWith {
                    _player removeEventHandler ["Local", _thisEventHandler];
                };
                systemChat "This unit was controlled by a player that disconnected, consider re-joining as a different slot.";
                //_player spawn {
                //    params ["_player"];
                //    sleep 5;
                //    _player setVariable ["startpos", (_player getVariable ["mjb_startpos", getPosASL player])];
                //};
            }];
        };
        //(group _unit) setVariable ["Vcm_Disable",true];        
        [(group _unit), 2] remoteExec ["setGroupOwner", 2]; 
        true
    }];
};

if (isDedicated) exitWith {};

if (mjb_plateToughness) then {
    player addEventHandler ["Hit", {
        player setVariable ["mjb_hitTime", cba_missionTime];
        [cba_missionTime] spawn mjb_arsenal_fnc_toughLoop;
    }];
};
if (mjb_plateSteal) then {
    ["ace_firedPlayer", { params["", "", "", "", "", "", "_projectile"];
        [_projectile] call mjb_arsenal_fnc_projHandler;
    }] call CBA_fnc_addEventHandler;
    ["ace_firedPlayerVehicle", { params["", "", "", "", "", "", "_projectile"];
        [_projectile] call mjb_arsenal_fnc_projHandler;
    }] call CBA_fnc_addEventHandler;
};

if (mjb_timerRegain > 0) then { [] spawn {
	sleep 1;
	// Credit: MajorDanvers
    diw_armor_plates_main_bleedMachine = [[player], true] call CBA_statemachine_fnc_create;
    private _bleedMachine = diw_armor_plates_main_bleedMachine;
    [_bleedMachine, {}, {diw_armor_plates_main_bleedWait = nil;}, {}, "halt"] call CBA_statemachine_fnc_addState;
    [_bleedMachine, {
        if (!alive player || {player getVariable ["diw_armor_plates_main_unconscious",false]}) exitWith { diw_armor_plates_main_toHalt = true; };
        if (!isNil "diw_armor_plates_main_bleedWait" && {diw_armor_plates_main_bleedWait}) exitWith {};
        private _bleedMalus = diw_armor_plates_main_bleedOutTimeMalus;
        private _bleedPenalty = diw_armor_plates_main_bleedOutTimeSubtraction;
        private _nextRegen = ((diw_armor_plates_main_bleedOutTime - _bleedMalus - _bleedPenalty) / (mjb_timerRegain)) max diw_armor_plates_main_minBleedOutTime;
        if (!isNil "diw_armor_plates_main_bleedWait") then {
                _bleedMalus = _bleedMalus - 1;
                if (_bleedMalus <= (-1 * _bleedPenalty)) exitWith {
                    diw_armor_plates_main_bleedOutTimeMalus = nil};
                diw_armor_plates_main_bleedOutTimeMalus = _bleedMalus;
        };
        diw_armor_plates_main_bleedWait = true;
        [
            { params ["_downed"];
                if (!isNil "diw_armor_plates_main_bleedWait" && {(player getVariable ["mjb_downed",0]) == _downed}) then {diw_armor_plates_main_bleedWait = false;};
            },
            [(player getVariable ["mjb_downed",0])],
            _nextRegen
        ] call CBA_fnc_waitAndExecute;
    }, {}, {}, "recovering"] call CBA_statemachine_fnc_addState;
    //[_bleedMachine, "halt", "recovering", ["diw_armor_plates_main_revive"], {true},{systemChat "activated"}, "Revived"] call CBA_statemachine_fnc_addEventTransition;
    [_bleedMachine, "halt", "recovering", { !(isNil "diw_armor_plates_main_bleedOutTimeMalus") && {!(player getVariable ["diw_armor_plates_main_unconscious",false])} },{player setVariable ["mjb_downed",cba_missionTime]}, "Revived"] call CBA_statemachine_fnc_addTransition;
    //[_bleedMachine, "recovering", "halt", ["diw_armor_plates_main_downed"], {true},{}, "Downed"] call CBA_statemachine_fnc_addEventTransition;
    [_bleedMachine, "recovering", "halt", { isNil "diw_armor_plates_main_bleedOutTimeMalus" }, {}, "Malus fully recovered"] call CBA_statemachine_fnc_addTransition;
    [_bleedMachine, "recovering", "halt", { diw_armor_plates_main_toHalt }, {diw_armor_plates_main_toHalt = false}, "Downed/Killed"] call CBA_statemachine_fnc_addTransition;
}; };

/*
mjb_arsenal_injectorCount = mjb_arsenal_maxLoadoutInjectors;
mjb_arsenal_injectorStash = 0;

waitUntil {!isNull player};
sleep 1;
private _count = 0;
private _fnc_count = {
    params ["_items", "_amounts"];
    {
        if (_x in diwako_armor_plates_main_injectorItems) then {
            _count = _count + (_amounts select _forEachIndex);
        };
    } forEach _items;
};
(getItemCargo uniformContainer _unit) call _fnc_count;
(getItemCargo vestContainer _unit) call _fnc_count;
(getItemCargo backpackContainer _unit) call _fnc_count;

if (_count < mjb_arsenal_maxLoadoutInjectors) then {
    mjb_arsenal_injectorCount = _count;
};
if (_count >= mjb_arsenal_maxLoadoutInjectors && {!isNull arsenal}) then {
    [arsenal, diwako_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems;
};
if (_count > mjb_arsenal_maxLoadoutInjectors) then {
    for _l from 1 to (_count - mjb_arsenal_maxLoadoutInjectors) do {
        [player, ""] call CBA_fnc_removeItem; }; // Needs to detect item class
};

player addEventHandler ["Put", {
    params ["_unit", "_container", "_item"];
    if !(_item in diwako_armor_plates_main_injectorItems) exitWith {};
    mjb_arsenal_injectorStash = mjb_arsenal_injectorStash + 1;
}];

// needs target event
player addEventHandler ["Take", {
    params ["_unit", "_container", "_item"];
    if !(_item in diwako_armor_plates_main_injectorItems) exitWith {};
    ["", _container] call CBA_fnc_targetEvent;
    if (owner _container == owner _unit) exitWith {};
    [{mjb_arsenal_injectorStash = mjb_arsenal_injectorStash + 1;}] remoteExec ["call", owner _container]; // ???
}];

["ace_arsenal_onLoadoutLoad", {
    params ["_loadout"];
    if !(player getUnitTrait "Medic") exitWith { };
    private _count = 0;
    private _fnc_count = {
        params ["_items", "_amounts"];
        {
            if (_x in diwako_armor_plates_main_injectorItems) then {
                _count = _count + (_amounts select _forEachIndex);
            };
        } forEach _items;
    };
    (getItemCargo uniformContainer _unit) call _fnc_count;
    (getItemCargo vestContainer _unit) call _fnc_count;
    (getItemCargo backpackContainer _unit) call _fnc_count;
    mjb_arsenal_injectorCount = _count;

    if ((_count + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {!isNull arsenal}) exitWith {
        [arsenal, diwako_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems;
    };
    [arsenal, diwako_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems;
}] call CBA_fnc_addEventHandler;

["ace_arsenal_cargoChanged", {
    params ["_display", "_item", "_addRemove"];
    if !(player getUnitTrait "Medic" || !(_item in diwako_armor_plates_main_injectorItems)) exitWith { };
    if (_addRemove) then {mjb_arsenal_injectorCount = mjb_arsenal_injectorCount + 1;
    } else {mjb_arsenal_injectorCount = mjb_arsenal_injectorCount - 1;};
    if (mjb_arsenal_injectorCount == mjb_arsenal_maxLoadoutInjectors) then {
        [arsenal, diwako_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems; };
    if (mjb_arsenal_injectorCount < mjb_arsenal_maxLoadoutInjectors) then {
        [arsenal, diwako_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems; };
}] call CBA_fnc_addEventHandler;