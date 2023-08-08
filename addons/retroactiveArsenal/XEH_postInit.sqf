#include "settings.sqf"
if (isServer) then {
    if (isMultiplayer && {mjb_slotSaverAI}) then {
		addMissionEventHandler ["HandleDisconnect", { params ["_unit","_id","_uid"];
			if (isCopilotEnabled vehicle _unit) then {_unit action ["UnlockVehicleControl", vehicle _unit];};
			private _savedId = _unit getVariable ["mjb_steamIDrop",true];
			if (_savedId isEqualTo true) then {
				_unit setVariable ["mjb_steamIDrop",_uid];
			};
			if (mjb_slotSaverAIExt) then {
				private _team = ((units _unit) - [_unit]);
				if (_team isNotEqualTo []) then {
					private _leader = leader _unit;
					if (_unit isEqualTo _leader) then {_leader = (_team select 0);} else {[group _unit, _unit] remoteExec ["selectLeader", _leader];};
					_unit attachTo [_leader,[0,-2,0]];
				};
				_unit disableAI "ALL";
				_unit allowDamage false;
				_unit hideObjectGlobal true;};
			_unit addEventHandler ["Local", { params ["_player"];
				if (isServer) then {
					[_player,{ params ["_player"];
						if ((_player getVariable ["mjb_steamIDrop",true]) isEqualTo (getPlayerUID player)) then {
							_player setVariable ["mjb_steamIDrop",nil,true];
						} else {
							systemChat "This unit was controlled by a player that disconnected, consider re-joining as a different slot.";
						};
						if (mjb_slotSaverAIExt) then {
							if !(isNull (attachedTo _player)) then {
								private _pos = ([_player, 3, 15, 3, 1, 0.7, 0] call BIS_fnc_findSafePos);
								if (count _pos > 2) then {_pos = getPosATL (attachedTo _player);} else {_pos = (_pos + [0]);};
								detach _player;
								_player setPosATL _pos;
							};
							_player hideObjectGlobal false;
							_player allowDamage true;};
					}] remoteExec ["call",_player];
				};
				_player removeEventHandler ["Local", _thisEventHandler];
			}];
			/*[_unit,_uid] spawn { params ["_unit","_uid"]; sleep 0.1;
            if !(alive _unit) exitWith {};
			if (isCopilotEnabled vehicle _unit) then {_unit action ["UnlockVehicleControl", vehicle _unit];};
            // locality death workaround
			_unit setVariable ["mjb_prevGroup", (_unit getVariable ["mjb_prevGroup", (group _unit)]),true];
            if (units _unit isNotEqualTo [_unit]) then {
			  //[_unit] joinSilent grpNull;
              //_unit setPosASL (_unit getVariable ["startpos",[0,0,0]]);
			};
            _unit disableAI "ALL";
            //_unit hideObjectGlobal true;
            _unit allowDamage false;
			private _savedId = (_unit getVariable ["mjb_steamIDrop",true]);
			if (_savedId isEqualTo true) then {
				_unit setVariable ["mjb_steamIDrop",_uid,true];
			};
			_unit addEventHandler ["Local", { _this spawn {
				params ["_player"];
//systemChat (format ["Unit locality changed: %1 to %2", (str _player), owner _player]);
				waitUntil {sleep 1; !local _player}; //exitWith {
					waitUntil {sleep 1; isPlayer _player};
//systemChat (format ["Executing re-join on: %1 for %2", (str _player), owner _player]);
					[_player, { params ["_player"];
						waitUntil {!isNull player};
						if (player isNotEqualTo _player) exitWith {systemChat "Re-join failed.";};
						//_player hideObjectGlobal false;
						//_player enableSimulationGlobal false;
						if ((_player getVariable ["mjb_steamIDrop",true]) isNotEqualTo (getPlayerUID player)) then {
							systemChat "This unit was controlled by a player that disconnected, consider re-joining as a different slot.";
						};
						private _action = (_player addAction ["<t color='#FF0000'>Return to Group</t>",{ params ["_unit","","_aId"];
								private _group = (_unit getVariable ["mjb_prevGroup", (group _unit)]);
								private _leader = leader _group;
								private _pos = ([_leader, 6, 15, 3, 1, 0.7, 0] call BIS_fnc_findSafePos);
								if (count _pos > 2) then {_pos = getPosATL _leader;} else {_pos = (_pos + [0]);};
								//_unit enableSimulationGlobal true;
								//_unit hideObjectGlobal false;
								_unit setPosATL _pos;
								if (_group isNotEqualTo group _unit) then {[_unit] joinSilent _group;};
								_unit setVariable ["mjb_prevGroup", nil,true];
								_unit setVariable ["mjb_steamIDrop",nil,true];
								_unit removeAction _aId;
							}, nil, 50
						]);
						//[_player, _action] spawn {params ['_player', '_action']; _player removeAction _action;};
					}] remoteExec ["spawn", _player];
				//};
				};
				_player removeEventHandler ["Local", _thisEventHandler];
			}];};*/
			//(group _unit) setVariable ["Vcm_Disable",true];
			//[(group _unit), 2] remoteExec ["setGroupOwner", 2];
			true
		}];
	};

	mjb_persistPls = 0 spawn {
		sleep 5;
		if !(isNil "mjb_persistenceActive") then {
			[{!(isNil "tmf_common_ending")}, {
				missionNamespace setVariable ["tmf_common_ending",true,true];
			}] call cba_fnc_waitUntilAndExecute;
		};
	};

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

if (isMultiplayer && {!isNil "ace_dragging"}) then {
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
			};
		}, nil] call CBA_fnc_addBISEventHandler;
	}
}, true, [], true] call CBA_fnc_addClassEventHandler;
};

// hack into players screen for a
/*if (isMultiplayer && {mjb_autoDeathSync}) then {
	["CAManBase", "InitPost", {
		params ["_unit"];
		if (!isServer && {(_unit in playableUnits)}) then { // || { !local _unit}
			// server triggers MPKilled so the event is useless for this?
			/*_unit addMPEventHandler ["MPKilled", { params ["_unit"];
				if (!isServer) exitWith {};
				if (isNil ("deathCheck" + (name _unit))) exitWith {};
				[[_unit,player], {
					params ["_unit"];
					if !(isNil ("deathCheck" + (name _unit))) exitWith {};
					missionNamespace setVariable [("deathCheck" + (name _unit)),true,true];
					_this spawn {  params ["_unit","_perceiver"];
						sleep 5;
						if (alive _unit) then {
							if (isPlayer _unit) exitWith { // Re-sync
								diag_log format ["Death De-sync detected: %1 death desynced for %2.", name _unit, name _perceiver];
								["mjb_resync", [_unit]] call CBA_fnc_localEvent;
							};
						};
						missionNamespace setVariable [("deathCheck" + (name _unit)),nil, true];
					};
				}] remoteExec ["call",2];
			}];///
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;
};*/

if (isMultiplayer && {mjb_zeusCompKilled && {isServer}}) then {
	["CAManBase", "InitPost", {
		params ["_unit"];
		if (local _unit || {isPlayer _unit}) exitWith {};
		_unit addMPEventHandler ["MPKilled", { params ["_unit"];
			if (!isServer || {local _unit}) exitWith {};
			_unit setOwner 2;
		}];
	}, true, [], false] call CBA_fnc_addClassEventHandler;
};
if (isMultiplayer && {mjb_resyncAction}) then { 0 spawn {
	waitUntil {cba_missionTime > 0};
	if (hasInterface) then {player createDiarySubject ["mjb_resync", "Resync"];};
	["CAManBase", "InitPost", {
		if (_unit in (playableUnits select {!(_x isKindOf "VirtualMan_F")})) then {
			_unit spawn { params ["_unit"]; waitUntil {sleep 5; isPlayer _unit};
				sleep 1;
				private _var = ("mjb_" + (((name _unit) splitString "([ ]/:){}") joinString ""));
				private _assign = (missionNamespace getVariable [_var,nil]);
				if (!isNil "_assign" && {hasInterface}) then {player removeDiaryRecord ["mjb_resync", (name _unit)];};
					missionNamespace setVariable [_var,_unit];
					if !(hasInterface) exitWith {};
					player createDiaryRecord  ["mjb_resync", [(name _unit),format ["<execute expression='if !(isNil ""mjb_syncCD"") exitWith {}; mjb_syncCD = false; [{mjb_syncCD = nil;},[],60] call CBA_fnc_waitAndExecute; [""mjb_resync"", %1] call CBA_fnc_serverEvent;'>[Re-sync State]</execute>",_var]]];
				//};
			};
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;
};};

if (isDedicated) exitWith {};

[] call mjb_arsenal_fnc_initStuff;

if !(hasInterface) exitWith {};

setTIParameter ["OutputRangeStart", mjb_thermalStart];
setTIParameter ["OutputRangeWidth", mjb_thermalWidth];

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

	/*if (isMultiplayer && {mjb_resyncAction}) then {
		//mjb_syncCD = true;
		/*private _action = [
			"mjb_resyncUnits","Re-sync",
			"\A3\ui_f\data\gui\cfg\Hints\Adjust_ca.paa",
			{ 	 params ["_target", "", ""];
				mjb_syncCD = true;
				[{mjb_syncCD = nil;},[],60] call CBA_fnc_waitAndExecute;
				{
					private _state = lifestate _x;
					if !(_state in ["DEAD","INCAPACITATED"]) exitWith {};
					["mjb_syncCheck", [_x,_target,_state]] call CBA_fnc_serverEvent;
				} forEach ((allPlayers select {!(_x isKindOf "VirtualMan_F")}) - _target);
			},  { (isNil "mjb_syncCD") },{ },[],[0,0,0],3,[false, true, false, false, true]
		] call ace_interact_menu_fnc_createAction;

		["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;///
		_text = "<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_PING</font> %PLAYER_PING_MIN %PLAYER_PING_AVG %PLAYER_PING_MAX<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_BANDWIDTH</font> %PLAYER_BANDWIDTH_MIN %PLAYER_BANDWIDTH_AVG %PLAYER_BANDWIDTH_MAX<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_DESYNC</font> %PLAYER_DESYNC<br/>%LINK_PLAYER_MUTE%LINK_PLAYER_KICK%LINK_PLAYER_BAN%LINK_PLAYER_VOTEKICK%LINK_PLAYER_VOTEADMIN";
		_textSquad = "<font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_PL_NAME</font> %PLAYER_FULLNAME<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_PL_MAIL</font> %PLAYER_EMAIL<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_PL_ICQ</font> %PLAYER_ICQ<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_PL_REMARK</font> %PLAYER_REMARK<br/>%PLAYER_SQUAD<br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br /><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_PING</font> %PLAYER_PING_MIN %PLAYER_PING_AVG %PLAYER_PING_MAX<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_BANDWIDTH</font> %PLAYER_BANDWIDTH_MIN %PLAYER_BANDWIDTH_AVG %PLAYER_BANDWIDTH_MAX<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_DESYNC</font> %PLAYER_DESYNC<br/>%LINK_PLAYER_MUTE%LINK_PLAYER_KICK%LINK_PLAYER_BAN%LINK_PLAYER_VOTEKICK%LINK_PLAYER_VOTEADMIN";
		_textUnit = "<br/>%PLAYER_UNIT<br/><img image='#(argb,8,8,3)color(1,1,1,0.1)' height='1' width='640' /><br /><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_PING</font> %PLAYER_PING_MIN %PLAYER_PING_AVG %PLAYER_PING_MAX<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_BANDWIDTH</font> %PLAYER_BANDWIDTH_MIN %PLAYER_BANDWIDTH_AVG %PLAYER_BANDWIDTH_MAX<br/><font color='#99ffffff' face='PuristaLight'>%$STR_DISP_MP_DESYNC</font> %PLAYER_DESYNC<br/>%LINK_PLAYER_MUTE%LINK_PLAYER_KICK%LINK_PLAYER_BAN%LINK_PLAYER_VOTEKICK%LINK_PLAYER_VOTEADMIN";
"<execute expression='if !(isNil ""mjb_syncCD"") exitWith {}; mjb_syncCD = false; [{mjb_syncCD = nil;},[],60] call CBA_fnc_waitAndExecute;'>[Re-sync State]</execute>";
	};*/
};

["CBA_loadoutSet", {
    params ["_unit", "", "_extradata"];
    private _mode = _extradata getOrDefault ["mjb_dagrMode", nil];
    if (!isNil "_mode" && {"ACE_microDAGR" in (_unit call ace_common_fnc_uniqueItems)}) then {
		if (_mode == -1) exitWith {}; [_mode] call ace_microdagr_fnc_openDisplay; };
    if ((_extradata getOrDefault ["mjb_gpsMode", false]) && {"ItemGPS" in (_unit call ace_common_fnc_uniqueItems)}) then {
		openGPS true;};
}] call CBA_fnc_addEventHandler;

["CBA_loadoutGet", {
    params ["_unit", "", "_extradata"];
    private _mode = missionNamespace getVariable ["ace_microdagr_currentShowMode",nil];
    if (!isNil "_mode") then {
        _extradata set ["mjb_dagrMode", _mode];};
	if (visibleGPS) then {_extradata set ["mjb_gpsMode", true];};
}] call CBA_fnc_addEventHandler;