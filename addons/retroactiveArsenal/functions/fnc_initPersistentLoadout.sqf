/*
  How to use:

    If you want persistence between multiple missions, put 'missionGroup = "missionGroupName";' in description.ext for each of the missions.

    Put '[player] call mjb_arsenal_fnc_initPersistentLoadout;' in initPlayerLocal.sqf

    '[player, false] call mjb_arsenal_fnc_initPersistentLoadout;' if you want them to keep their saved loadout even if they die in a mission.
*/

params [["_player",player,[objNull]], ["_deleteOnDeath",true,[false]]];

mjb_deleteOnDeath = _deleteOnDeath;

if (isServer) then {
    addMissionEventHandler ["Ended", {
        {   if (mjb_saveLoadout > 0) then {
                if (alive player && { not (typeOf player in ["VirtualSpectator_F","ace_spectator_virtual","TMF_spectator_unit"]) } ) then {
                missionProfileNamespace setVariable [mjb_pLoadName, ([_unit] call CBA_fnc_getLoadout)]; };
                saveMissionProfileNamespace;};
        } remoteExec ["call",([0,-2] select isDedicated)];
    }];
};


if (mjb_saveLoadout < 1 || {!hasInterface}) exitWith {};

waitUntil {!isNull player};

mjb_pLoadName = getText (missionConfigFile >> "missionGroup");
if (mjb_pLoadName isEqualTo "") then {mjb_pLoadName = "mjb_loadout" + missionName;
} else {mjb_pLoadName = "mjb_loadout" + mjb_pLoadName};
private _varName = mjb_pLoadName;

_player addEventHandler ["Killed", {
    params ["_unit"];
    if (mjb_deleteOnDeath) then {
        missionProfileNamespace setVariable [mjb_pLoadName, nil];
		saveMissionProfileNamespace; 
    };
}];

if (mjb_saveLoadout in [1,3]) then {
    _player addEventHandler ["InventoryClosed", {
        params ["_unit", ""];
        missionProfileNamespace setVariable [mjb_pLoadName, ([_unit] call CBA_fnc_getLoadout)];
		saveMissionProfileNamespace;
    }];
};

if (mjb_saveLoadout in [2,3]) then {
    [_player, _varName] spawn {
        params ["_unit","_varName"];
        while {alive _unit} do {
            sleep 300;
            missionProfileNamespace setVariable [_varName, ([_unit] call CBA_fnc_getLoadout)];
			saveMissionProfileNamespace;
        };
    };
};

private _loadout = (missionProfileNamespace getVariable _varName);
if !(isNil "_loadout") then {
    sleep 0.5;
    [_player, _loadout, true] call CBA_fnc_setLoadout;
};