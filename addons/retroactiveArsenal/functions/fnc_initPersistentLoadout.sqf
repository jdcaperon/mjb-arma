/*
  How to use:

    If you want persistence between multiple missions, put 'missionGroup = "missionGroupName";' in description.ext for each of the missions.

    Put '[player] call mjb_arsenal_fnc_initPersistentLoadout;' in initPlayerLocal.sqf

    '[player, false] call mjb_arsenal_fnc_initPersistentLoadout;' if you want them to keep their saved loadout even if they die in a mission.

    '[player, true, "yourLoadoutNameHere"] call mjb_arsenal_fnc_initPersistentLoadout;' to set a different loadout slot within the same missionGroup.

    '[player, true, "yourLoadoutNameHere", true] call mjb_arsenal_fnc_initPersistentLoadout;' to use profileNamespace instead of missionProfileNamespace for player loadouts.
*/

params [["_player",player,[objNull]], ["_deleteOnDeath",true,[false]], ["_missionGroup","",[""]], ["_override",false,[false]]];


if (mjb_saveLoadout < 1 || {!hasInterface}) exitWith {};

waitUntil {!isNull player};


mjb_deleteOnDeath = _deleteOnDeath;
mjb_profOverride = _override;

mjb_pLoadName = _missionGroup;
if (mjb_pLoadName isEqualTo "") then {mjb_pLoadName = (getText (missionConfigFile >> "missionGroup"));};
if (mjb_pLoadName isEqualTo "") then {mjb_pLoadName = "mjb_loadout" + missionName;
} else {mjb_pLoadName = "mjb_loadout" + mjb_pLoadName};
private _varName = mjb_pLoadName;

if !(isNil "mjb_persistDeathHandle") then {_player removeEventHandler ["Killed",mjb_persistDeathHandle]};
mjb_persistDeathHandle = (_player addEventHandler ["Killed", {
    params ["_unit"];
    if (mjb_deleteOnDeath) then {
        if (mjb_profOverride) exitWith {profileNamespace setVariable [mjb_pLoadName, nil]; saveProfileNamespace;};
        missionProfileNamespace setVariable [mjb_pLoadName, nil];
        saveMissionProfileNamespace;
    };
}]
);

if (true) then { // was isServer, but does not get added due to this being run on clients only when dedicated
        //addMissionEventHandler ["MPEnded", {
            //{
mjb_persistEndHandle = (0 spawn {
    waitUntil { !isNull findDisplay 46 };
    findDisplay 46 displayAddEventHandler ["Unload",
    {
                    if (alive player && { not (typeOf player in ["VirtualSpectator_F","ace_spectator_virtual","TMF_spectator_unit"]) } ) then {
                        if (mjb_profOverride) exitWith {profileNamespace setVariable [mjb_pLoadName, ([_unit] call CBA_fnc_getLoadout)]; saveProfileNamespace;};
						missionProfileNamespace setVariable [mjb_pLoadName, ([_unit] call CBA_fnc_getLoadout)];
						saveMissionProfileNamespace; 
					};
    }];
});
            //} remoteExec ["call",([0,-2] select isDedicated)];
        //}];
};

if (mjb_saveLoadout in [1,3]) then {
    if !(isNil "mjb_persistInvHandle") then {_player removeEventHandler ["InventoryClosed",mjb_persistInvHandle]};
    mjb_persistInvHandle =  (_player addEventHandler ["InventoryClosed", {
        params ["_unit", ""];
        if (!alive _unit) exitWith {};
        if (mjb_profOverride) exitWith {profileNamespace setVariable [mjb_pLoadName, ([_unit] call CBA_fnc_getLoadout)]; saveProfileNamespace;};
        missionProfileNamespace setVariable [mjb_pLoadName, ([_unit] call CBA_fnc_getLoadout)];
        saveMissionProfileNamespace;
    }]);
};

if (mjb_saveLoadout in [2,3]) then {
    mjb_persistDelayHandle = ([_player, _varName] spawn {
        params ["_unit","_varName"];
        sleep 300;
        while {alive _unit} do {
            if (mjb_profOverride) exitWith {profileNamespace setVariable [_varName, ([_unit] call CBA_fnc_getLoadout)]; saveProfileNamespace;};
            missionProfileNamespace setVariable [_varName, ([_unit] call CBA_fnc_getLoadout)];
            saveMissionProfileNamespace;
            sleep 300;
        };
    });
};

private _loadout = nil;
if (_override) then {_loadout = (profileNamespace getVariable _varName);
    } else {_loadout = (missionProfileNamespace getVariable _varName);};
if !(isNil "_loadout") then {
    sleep 0.5;
    [_player, _loadout, true] call CBA_fnc_setLoadout;
    if !(isNil "arsenal") then {
        [arsenal, [primaryWeaponMagazine player, handgunMagazine player]] call ace_arsenal_fnc_addVirtualItems;
    };
    if (secondaryWeapon player != "") then {
        if ((count (secondaryWeaponMagazine player)) < 1) then {
            private _magazine = ((getArray (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "magazines")) select 0);
            player addSecondaryWeaponItem _magazine;
        };
    };
};