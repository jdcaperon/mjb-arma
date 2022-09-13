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
		true
	}];
};

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