#include "settings.sqf"
if (isServer) then {
	if (isMultiplayer) then {
		if (mjb_slotSaverAI) then {
			mjb_disconnectHandle = (addMissionEventHandler ["HandleDisconnect", { params ["_unit","_id","_uid"];
				if (isCopilotEnabled vehicle _unit) then {_unit action ["UnlockVehicleControl", vehicle _unit];};
				private _savedId = _unit getVariable ["mjb_steamIDrop",true];
				if (_savedId isEqualTo true) then {
					_unit setVariable ["mjb_steamIDrop",_uid,true];
				};
				if (mjb_slotSaverAIExt) then {
					private _team = ((units _unit) - [_unit]);
					if (_team isNotEqualTo []) then {
						private _leader = leader _unit;
						if (_unit isEqualTo _leader) then {_leader = (_team select 0);} else {[group _unit, _unit] remoteExec ["selectLeader", _leader];};
						_unit attachTo [_leader,[0,-5,0]];
					};
					if (vehicle _unit isEqualTo _unit) then { _unit disableAI "ALL";
						_unit hideObjectGlobal true; };
					_unit allowDamage false;
				};
				private _ogGroup = (_unit getVariable ["mjb_ogGroup",grpNull]);
				if (mjb_slotSaverAIExt && {_ogGroup isNotEqualTo group _unit}) then {
					if (isNil "mjb_disconnects") then {mjb_disconnects = [];};
					mjb_disconnects pushBack _uid;
					mjb_groupDisconnectHandler = (addMissionEventHandler ["PlayerConnected", {
						params ["", "_uid","_name"];
						if (_uid in mjb_disconnects) then {
							private _units = playableUnits;
							private _index = _units findIf {(_x getVariable ["mjb_steamIDrop",""]) isEqualTo _uid};
							if (_index < 0) exitWith {};
							private _unit = (_units select _index);
							if (alive _unit && {!(typeOf _unit in ["tmf_spectator","ace_spectator_virtual","virtualSpectator_F"])}) then {
								private _targetID = owner (allPlayers select (allPlayers findIf {name _x isEqualTo _name}));
								[_unit,_targetID,_uid] spawn {params ["_unit","_targetID","_uid"];
									waitUntil {sleep 5; !isNull (_uid call BIS_fnc_getUnitByUID)};
									_unit setOwner _targetID;
									sleep 5;
									[_unit,{
										mjb_self = player; selectPlayer _this;
										if (typeOf mjb_self in ["tmf_spectator","ace_spectator_virtual","virtualSpectator_F"]) then { deleteVehicle mjb_self; };
										(uiNamespace getVariable "RscDisplayInterrupt") closeDisplay 1;
										while {dialog} do { closeDialog 0; };
										player spawn mjb_arsenal_fnc_tmfSpawnFix;
									}] remoteExec ["call", _targetID];
								};
							};
							mjb_disconnects deleteAt (mjb_disconnects findIf {_x isEqualTo _uid});
							if (mjb_disconnects isEqualTo []) then {
								mjb_disconnects = nil;
								removeMissionEventHandler ["PlayerConnected",mjb_groupDisconnectHandler];
							};
						}
					}]);
				};
				_unit addEventHandler ["Local", { params ["_player"];
					if (isServer && {!local _player}) then {
						[_player,{ params ["_player"];
							waitUntil {sleep 5; !isNull player};
							sleep 5;
							if (player isEqualTo _player) then {
								if ((_player getVariable ["mjb_steamIDrop",true]) isEqualTo (getPlayerUID player)) then {
									_player setVariable ["mjb_steamIDrop",nil,true];
								} else {
									systemChat "This unit was controlled by a player that disconnected, consider re-joining as a different slot.";
								};
							};
							if (mjb_slotSaverAIExt) then {
								if !(isNull (attachedTo _player)) then {
									private _attachedUnit = (attachedTo _player);
									private _vehicle = vehicle _attachedUnit;
									_player enableAI "ALL";
									if (_vehicle isNotEqualTo _attachedUnit && {(_vehicle emptyPositions "") > 0}) exitWith {
										detach _player;
										_player moveInAny _vehicle;
										[_player, false] remoteExec ["hideObjectGlobal", 2];
										_player allowDamage true;
									};
									private _pos = ([_vehicle, 3, 15, 3, 1, 0.7, 0] call BIS_fnc_findSafePos);
									if (count _pos > 2) then {_pos = getPosATL _vehicle;} else {_pos = (_pos + [0]);};
									detach _player;
									_player setPosATL _pos;
								};
								[_player, false] remoteExec ["hideObjectGlobal", 2];
								_player allowDamage true;
							};
						}] remoteExec ["spawn",_player];
						_player removeEventHandler ["Local", _thisEventHandler];
					};
				}];
				true
			}]);
		};

		if (mjb_resyncAction) then {
			["mjb_resync", {
				_this spawn {
					params ["_unit"];
					if (isPlayer _unit) exitWith {
						private _owner = owner _unit;
						_unit setOwner 2;
						sleep 1;
						_unit setOwner _owner;
					};
					//if (_unit in playableUnits) exitWith {};
					//_unit setDamage [1,false];
				};
			}] call CBA_fnc_addEventHandler;

			["mjb_syncCheck", {  params ["_unit","_caller","_state"];
				private _servState = lifestate _unit;
				if (_servState isEqualTo _state) exitWith {};
				diag_log (format ["MJB Arma: %1, %4, desync'd as %3 for %2, resyncing.",(name _unit),(name _caller),_state,_servState]);
				["mjb_resync", _unit] call CBA_fnc_serverEvent;
			}] call CBA_fnc_addEventHandler;
		};

		["mjb_killedToServer", {  params ["_unit"];
			if (local _unit || {isPlayer _unit}) exitWith {};
			private _inited = _unit getVariable ["mjb_killedReturn", nil];
			if (isNil "_inited") then {
				if (!alive _unit) exitWith {
					_unit spawn { private _deadTime = time;
						waitUntil {sleep 5; !isAwake _this || {(time - _deadTime) > 15}};
						_this setOwner 2;};
				};
				_unit setVariable ["mjb_killedReturn", true];
				_unit addMPEventHandler ["MPKilled", { params ["_unit"];
					if (!isServer || {local _unit}) exitWith {_unit setVariable ["mjb_killedReturn", nil];};
					//[{!isAwake _this},{_this setOwner 2;},_unit,15,{_this setOwner 2;}] call cba_fnc_waitUntilAndExecute;
					_unit spawn { private _deadTime = time;
						waitUntil {sleep 5; !isAwake _this || {(time - _deadTime) > 15}};
						_this setOwner 2; _this setVariable ["mjb_killedReturn", nil];};
				}];
			};
			//[_unit,{waitUntil {sleep 5; !isAwake _this}; _this setOwner 2;}] remoteExec ["spawn",2];
		}] call CBA_fnc_addEventHandler;

		if (mjb_zeusCompKilled) then {
			["CAManBase", "InitPost", {
				params ["_unit"];
				["mjb_killedToServer", [_unit]] call CBA_fnc_serverEvent;
			}, true, [], false] call CBA_fnc_addClassEventHandler;
		};
	};
};

if (mjb_dropPlate) then {
	["CAManBase", "InitPost", {
		params ["_unit"];
		if (isPlayer _unit || { !local _unit}) exitWith {};
		_unit spawn {  params ["_unit"];
			sleep 6;
			if !("diw_armor_plates_main_plate" in (_unit call ace_common_fnc_uniqueItems)) exitWith {};
			[_unit, "Killed", {  params ["_unit"];
				if (!isNull (objectParent _unit)) exitWith {};
				_unit spawn {  params ["_unit"];
					sleep 1;
					private _count = 0;
					while {[_unit, "diw_armor_plates_main_plate"] call CBA_fnc_removeItem} do {_count = _count + 1;};
					private _deathBox = (_unit nearObjects ["WeaponHolderSimulated",2] select 0);
					if (isNil "_deathBox") then {
						_deathBox = createVehicle ["GroundWeaponHolder",_unit,[],0.6,"CAN_COLLIDE"];
						private _dBoxPos = getPosATL _deathBox;
						if !(surfaceIsWater _dBoxPos) exitWith {_deathBox setPosATL [(_dBoxPos # 0),(_dBoxPos # 1),0]};
						_dBoxPos = getPosASL _deathBox;
						private _height = ((getPosASL _unit) # 2);
						_deathBox setPosASL [(_dBoxPos # 0),(_dBoxPos # 1),_height];
						/*if (((getPosASL _deathBox) # 2) < 0) then {
							private _height = ((getPosASL _unit) # 2);
							_deathBox setPosASL [((getPosASL _deathBox) select 0), ((getPosASL _deathBox) select 1), _height];
							if (getPosATL _deathBox # 2 < 0) then {
								_deathBox setPosATL [((getPosATL _deathBox) select 0), ((getPosATL _deathBox) select 1), 0];};
						};*/
					};
					_deathBox addItemCargoGlobal ["diw_armor_plates_main_plate",_count];
					if (!isServer) then { [_deathBox,2] remoteExec ["setOwner",2]};
				};
			}, nil] call CBA_fnc_addBISEventHandler;
		}
	}, true, [], true] call CBA_fnc_addClassEventHandler;
};

if (mjb_disableGunnerBail) then {
	[{  private _eventHash = (cba_events_eventHashes getVariable ["ace_vehicle_damage_bailOut", nil]);
		private _eventId = [_eventHash, "#lastId"] call CBA_fnc_hashGet;
		if (isServer && {_eventId > 0}) then {systemChat "PCA > Disable gunner bail being on may cause issues due to another mod besides ACE using the same event."};
		["ace_vehicle_damage_bailOut", 0] call CBA_fnc_removeEventHandler;
		["ace_vehicle_damage_bailOut", {
			params ["_center", "_crewman", "_vehicle"];

			if (isPlayer _crewman) exitWith {};
			private _canShoot = (_vehicle getVariable ["ace_vehicle_damage_canShoot",true]);
			if (!alive _crewman || { !( [_crewman] call ace_common_fnc_isAwake) || {_crewman isEqualTo (gunner _vehicle) && {_canShoot}}} ) exitWith {};

			unassignVehicle _crewman;
			if (!_canShoot) then {_crewman leaveVehicle _vehicle;};
			doGetOut _crewman;

			private _angle = floor (random 360);
			private _dist = (30 + (random 10));
			private _escape = _center getPos [_dist, _angle];

			_crewman doMove _escape;
			_crewman setSpeedMode "FULL";
		}] call CBA_fnc_addEventHandler;
	}, nil, 3] call cba_fnc_waitAndExecute;
};

if (isMultiplayer) then {
	if (!isNil "ace_dragging") then {
		mjb_carryLocalHandle = ["mjb_carryLocal", {
			_this spawn {
				params["_player", "_obj"];
				sleep 0.2;
				if (_player distance _obj > 10) then {
					_this call ace_dragging_fnc_carryObject;
				};
			};
		}] call CBA_fnc_addEventHandler;

		mjb_carryHandle = ["mjb_carryHandler", { params ["_obj"];
			private _carrier = attachedTo _obj;
			if (isNull _carrier) exitWith {};
			if ((owner _carrier) isEqualTo (owner _obj)) exitWith {};
			_obj setOwner (owner _carrier);
			["mjb_carryLocal", [_carrier, _obj], _carrier] call CBA_fnc_targetEvent;
		}] call CBA_fnc_addEventHandler;

		mjb_handoffHandle = ["ace_common_setDir", {
			if ((_this select 0) isKindOf "CAManBase") exitWith {};
			["mjb_carryHandler", [(_this select 0)]] call CBA_fnc_serverEvent;
		}] call CBA_fnc_addEventHandler;
	};
	if (mjb_resyncAction) then {
		if (hasInterface) then {player createDiarySubject ["mjb_resync", "Resync"];};
		mjb_resyncEH = (["mjb_resyncPlayer", { params ["_unit"];
			_unit spawn { params ["_unit"]; waitUntil {sleep 5; isPlayer _unit};
				sleep 1;
				private _var = ("mjb_" + (((name _unit) splitString "([ ]/:){}") joinString ""));
				private _assign = (missionNamespace getVariable [_var,nil]);
				missionNamespace setVariable [_var,_unit];
				if (!hasInterface || {!isNil "_assign"}) exitWith {};
				player createDiaryRecord  ["mjb_resync", [(name _unit),format ["<execute expression='if !(isNil ""mjb_syncCD"") exitWith {}; mjb_syncCD = false; [{mjb_syncCD = nil;},[],60] call CBA_fnc_waitAndExecute; [""mjb_resync"", %1] call CBA_fnc_serverEvent;'>[Re-sync State]</execute>",_var]]];
			};
		}] call CBA_fnc_addEventHandler);
		0 spawn { waitUntil {sleep 1; !isNull player};
			sleep 3;
			private _var = ("mjb_" + (((name player) splitString "([ ]/:){}") joinString ""));
			["mjb_resyncPlayer",[player], _var] call CBA_fnc_globalEventJIP;
		};
	};
	if !(hasInterface) exitWith {};
	if !(isNil "zen_remote_control") then {
		["zen_remoteControlStopped", {
			if (isServer) exitWith {};
				["mjb_killedToServer", [_this]] call CBA_fnc_serverEvent;
			//[_this,{waitUntil {sleep 5; !isAwake _this}; _this setOwner 2;}] remoteExec ["spawn",2];
		}] call CBA_fnc_addEventHandler;
	} else {
		["ModuleCurator_F", "InitPost", { params ["_curator"];
			systemChat str ([_curator, "curatorObjectRemoteControlled", {params ["_curator", "_player", "_unit", "_isRemoteControlled"];
				if (isServer) exitWith {};
				if !(_isRemoteControlled) then {
					["mjb_killedToServer", [_unit]] call CBA_fnc_serverEvent;
				};
			}] call BIS_fnc_addScriptedEventHandler);
		}, false, [], true] call CBA_fnc_addClassEventHandler;
	};

	if (mjb_slotSaverAIExt) then {
		player setVariable ["mjb_ogGroup",(group _unit),true];
	};
};

if (isDedicated) exitWith {};

[] call mjb_arsenal_fnc_initStuff;

if !(hasInterface) exitWith {};

setTIParameter ["OutputRangeStart", mjb_thermalStart];
setTIParameter ["OutputRangeWidth", mjb_thermalWidth];

if (mjb_plateToughness) then {
    ["ace_overpressure", {
        player setVariable ["mjb_hitTime", cba_missionTime];
        [cba_missionTime] spawn mjb_arsenal_fnc_toughLoop;
    }] call CBA_fnc_addEventHandler;
};

if (!isNil "ace_interact_menu") then {
	private _action = [
		"mjb_uniformFix","Fix Uniform",
		"\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa",
		{ 	 params ["", "_player", ""];
			// will break plates until update
			//[_player,([_player] call CBA_fnc_getLoadout),false] call CBA_fnc_setLoadout;
			_player call mjb_arsenal_fnc_switchUniform;
		},  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
	] call ace_interact_menu_fnc_createAction;

	["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

if (mjb_plateSteal) then {
    ["ace_firedPlayer", { params["", "", "", "", "", "", "_projectile"];
        [_projectile] call mjb_arsenal_fnc_projHandler;
    }] call CBA_fnc_addEventHandler;
    ["ace_firedPlayerVehicle", { params["", "", "", "", "", "", "_projectile"];
        [_projectile] call mjb_arsenal_fnc_projHandler;
    }] call CBA_fnc_addEventHandler;
};

["CBA_loadoutSet", {
    params ["_unit", "", "_extradata"];
    private _mode = _extradata getOrDefault ["mjb_dagrMode", nil];
    if (!isNil "_mode" && {"ACE_microDAGR" in (_unit call ace_common_fnc_uniqueItems)}) then {
		if (_mode == -1) exitWith {}; [_mode] call ace_microdagr_fnc_openDisplay; };
    if ((_extradata getOrDefault ["mjb_gpsMode", false]) && {"ItemGPS" in (_unit call ace_common_fnc_uniqueItems)}) then {
		openGPS true;};
	[_unit,(_extradata getOrDefault ["mjb_goggles", ""])] spawn { params ["_unit","_goggs"]; sleep 1;
//systemChat (_goggs + ", " + (goggles _unit) + ".");
		if (_goggs isNotEqualTo "") then {
			_unit addGoggles _goggs;
//systemChat ((goggles _unit) + ".");
		};
	};
}] call CBA_fnc_addEventHandler;

["CBA_loadoutGet", {
    params ["_unit", "", "_extradata"];
    private _mode = missionNamespace getVariable ["ace_microdagr_currentShowMode",nil];
    if (!isNil "_mode") then {
        _extradata set ["mjb_dagrMode", _mode];};
	if (visibleGPS) then {_extradata set ["mjb_gpsMode", true];};
	private _goggs = goggles _unit; 
	if (_goggs isNotEqualTo "") then {
		_extradata set ["mjb_goggles", _goggs];
	};
}] call CBA_fnc_addEventHandler;

mjb_persistHandle = ["mjb_modulePersist", {
	[player] spawn mjb_arsenal_fnc_initPersistentLoadout;
}] call CBA_fnc_addEventHandler;


if (mjb_arsenal_maxLoadoutInjectors > 0) then {
	["CBA_loadoutSet", {
		params ["_unit"];
		if (isNil "arsenal") exitWith {};
		private _count = 0;
		private _fnc_count = {
			params ["_items", "_amounts"];
			{
				if (_x in diw_armor_plates_main_injectorItems) then {
					_count = _count + (_amounts select _forEachIndex);
				};
			} forEach _items;
		};
		(getItemCargo uniformContainer _unit) call _fnc_count;
		(getItemCargo vestContainer _unit) call _fnc_count;
		(getItemCargo backpackContainer _unit) call _fnc_count;
		mjb_arsenal_injectorCount = _count;
		if ((_count + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {!isNull arsenal && {player getUnitTrait "Medic"}}) exitWith {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems;
		};
		[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems;

        if (_count <= 0) exitWith {};
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) > mjb_arsenal_maxLoadoutInjectors) then {
            private _remove = ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) - mjb_arsenal_maxLoadoutInjectors);
			for "_l" from 1 to _remove do
            {
				["diw_armor_plates_main_consumeInjectorUse", [player]] call CBA_fnc_localEvent;
                _count = _count - 1;
                if (_count <= 0) exitWith {};
            };
		    mjb_arsenal_injectorCount = _count max 0;
		};
	}] call CBA_fnc_addEventHandler;

	["ace_arsenal_displayOpened", {
		private _count = 0;
		private _fnc_count = {
			params ["_items", "_amounts"];
			{
				if (_x in diw_armor_plates_main_injectorItems) then {
					_count = _count + (_amounts select _forEachIndex);
				};
			} forEach _items;
		};
        private _unit = player;
		(getItemCargo uniformContainer _unit) call _fnc_count;
		(getItemCargo vestContainer _unit) call _fnc_count;
		(getItemCargo backpackContainer _unit) call _fnc_count;
		mjb_arsenal_injectorCount = _count;

		if ((_count + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {!isNull arsenal && {player getUnitTrait "Medic"}}) exitWith {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems;
		};
		[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems;
	}] call CBA_fnc_addEventHandler;

	["ace_arsenal_displayClosed", {
		params ["_loadout"];
		private _count = 0;
		private _fnc_count = {
			params ["_items", "_amounts"];
			{
				if (_x in diw_armor_plates_main_injectorItems) then {
					_count = _count + (_amounts select _forEachIndex);
				};
			} forEach _items;
		};
        private _unit = player;
		(getItemCargo uniformContainer _unit) call _fnc_count;
		(getItemCargo vestContainer _unit) call _fnc_count;
		(getItemCargo backpackContainer _unit) call _fnc_count;
		mjb_arsenal_injectorCount = _count;

		if ((_count + mjb_arsenal_injectorStash) > mjb_arsenal_maxLoadoutInjectors) then {
            private _remove = (_count - mjb_arsenal_maxLoadoutInjectors);
			for "_l" from 1 to _remove do {
				["diw_armor_plates_main_consumeInjectorUse", [player]] call CBA_fnc_localEvent;
                _count = _count - 1;
                if (_count <= 0) exitWith {};
            };
		    mjb_arsenal_injectorCount = _count max 0;
		};
	}] call CBA_fnc_addEventHandler;

	["ace_arsenal_cargoChanged", {
		params ["_display", "_item", "_addRemove"];
		if !(_item in diw_armor_plates_main_injectorItems) exitWith { };
		if (_addRemove > 0) then {mjb_arsenal_injectorCount = mjb_arsenal_injectorCount + 1;
		} else {mjb_arsenal_injectorCount = mjb_arsenal_injectorCount - 1;};
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) >= mjb_arsenal_maxLoadoutInjectors) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems; };
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {player getUnitTrait "Medic"}) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems; };
	}] call CBA_fnc_addEventHandler;
};