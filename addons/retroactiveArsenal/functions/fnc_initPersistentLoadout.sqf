/*
  How to use:

    If you want persistence between multiple missions, put 'missionGroup = "missionGroupName";' in description.ext for each of the missions.

    Put '[player] spawn mjb_arsenal_fnc_initPersistentLoadout;' in initPlayerLocal.sqf

    '[player, false] spawn mjb_arsenal_fnc_initPersistentLoadout;' if you want them to keep their saved loadout even if they die in a mission.

    '[player, true, "yourLoadoutNameHere"] spawn mjb_arsenal_fnc_initPersistentLoadout;' to set a different loadout slot within the same missionGroup.

    '[player, true, "yourLoadoutNameHere", true] spawn mjb_arsenal_fnc_initPersistentLoadout;' to use profileNamespace instead of missionProfileNamespace for player loadouts.
*/

params [["_player",player,[objNull]], ["_deleteOnDeath",true,[false]], ["_missionGroup","",[""]], ["_override",false,[false]]];


if ( !hasInterface || {mjb_saveLoadout < 1} ) exitWith {};
if !(canSuspend) exitWith {_this spawn mjb_arsenal_fnc_initPersistentLoadout;};

mjb_deleteOnDeath = _deleteOnDeath;
mjb_profOverride = _override;

mjb_pLoadName = _missionGroup;
if (mjb_pLoadName isEqualTo "") then {mjb_pLoadName = (getText (missionConfigFile >> "missionGroup"));};
if (mjb_pLoadName isEqualTo "") then {mjb_pLoadName = "mjb_loadout" + missionName;
} else {if !("mjb_loadout" in mjb_pLoadName) then {mjb_pLoadName = "mjb_loadout" + mjb_pLoadName;};};

if (isNil "mjb_persistenceActive") then {
	missionNamespace setVariable ["mjb_persistenceActive", true, true];
	[{ if (isNil "mjb_persistPls") then {
		mjb_persistPls = 0 spawn {
			sleep 5;
			if !(isNil "mjb_persistenceActive") then {
				[{!(isNil "tmf_common_ending")}, {
					missionNamespace setVariable ["tmf_common_ending",true,true];
				}] call cba_fnc_waitUntilAndExecute;
			};
		};}; }] remoteExec ["call", 2];
};

waitUntil {!isNull player};

mjb_persistEnd = ([_player] spawn { params ["_unit"];
	waitUntil { sleep 1; !alive _unit || {!(isNil "tmf_common_ending")} };
	if (alive _unit) then {
		private _loadout = ([player] call CBA_fnc_getLoadout);
		if (isNil "_loadout") exitWith {false};
		if (_loadout isEqualTo []) exitWith {false};
		if (mjb_profOverride) exitWith {profileNamespace setVariable [mjb_pLoadName, _loadout]; saveProfileNamespace;};
		missionProfileNamespace setVariable [mjb_pLoadName, _loadout];
		saveMissionProfileNamespace;
	};
});

private _varName = mjb_pLoadName;

if !(isNil "mjb_persistDeathHandle") then {_player removeEventHandler ["Killed",mjb_persistDeathHandle]};
mjb_persistDeathHandle = (_player addEventHandler ["Killed", {
	if (mjb_deleteOnDeath) then {
		if (mjb_profOverride) exitWith { profileNamespace setVariable [mjb_pLoadName, nil]; saveProfileNamespace; };
		missionProfileNamespace setVariable [mjb_pLoadName, nil];
		saveMissionProfileNamespace;
//systemChat "Persistent loadout lost.";
	};
}]);
/*
if (true) then { // was isServer, but does not get added due to this being run on clients only when dedicated
	mjb_persistEndHandle = (0 spawn {
		waitUntil {sleep 1; !isNull findDisplay 46 };
		findDisplay 46 displayAddEventHandler ["Unload",
		{
			if (alive player) then {
				private _loadout = ([_unit] call CBA_fnc_getLoadout);
				if (isNil "_loadout") exitWith {false};
				if (mjb_profOverride) exitWith {profileNamespace setVariable [mjb_pLoadName, _loadout]; saveProfileNamespace;};
				missionProfileNamespace setVariable [mjb_pLoadName, _loadout];
				saveMissionProfileNamespace;
			};
		}];
	});
};*/

if (mjb_saveLoadout in [1,3]) then {
    if !(isNil "mjb_persistInvHandle") then {_player removeEventHandler ["InventoryClosed",mjb_persistInvHandle]};
    mjb_persistInvHandle =  (_player addEventHandler ["InventoryClosed", {
        params ["_unit", ""];
        if (!alive _unit) exitWith {};
		private _loadout = ([_unit] call CBA_fnc_getLoadout);
		if (isNil "_loadout") exitWith {false};
        if (mjb_profOverride) exitWith {profileNamespace setVariable [mjb_pLoadName, _loadout]; saveProfileNamespace;};
        missionProfileNamespace setVariable [mjb_pLoadName, _loadout];
        saveMissionProfileNamespace;
    }]);
};

if (mjb_saveLoadout in [2,3]) then {
    mjb_persistDelayHandle = ([_player, _varName] spawn {
        params ["_unit","_varName"];
        sleep 300;
        while {alive _unit} do {
			private _loadout = ([_unit] call CBA_fnc_getLoadout);
			if (isNil "_loadout") exitWith {false};
			if (mjb_profOverride) exitWith {profileNamespace setVariable [mjb_pLoadName, _loadout]; saveProfileNamespace;};
			missionProfileNamespace setVariable [mjb_pLoadName, _loadout];
			saveMissionProfileNamespace;
            sleep 300;
        };
    });
};

private _loadout = nil;
if (_override) then {_loadout = (profileNamespace getVariable [_varName,nil]);
    } else {_loadout = (missionProfileNamespace getVariable [_varName,nil]);
};
sleep 0.5;
if (isNil "_loadout" ) exitWith {systemChat "Persistent loadout not found.";};
if (_loadout isEqualTo []) exitWith {systemChat "Persistent loadout empty.";};
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
systemChat "Persistent loadout loaded.";