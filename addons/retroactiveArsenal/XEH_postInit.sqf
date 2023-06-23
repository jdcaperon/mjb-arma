#include "settings.sqf"
if (isServer) then {
    if (mjb_slotSaverAI) then {
		addMissionEventHandler ["HandleDisconnect", {
			params ["_unit","_id","_uid"];
			if (isCopilotEnabled vehicle _unit) then {_unit action ["UnlockVehicleControl", vehicle _unit];};
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

	mjb_persistPls = 0 spawn {
		sleep 5;
		if !(isNil "mjb_persistenceActive") then {
			[{!(isNil "tmf_common_ending")}, {
				missionNamespace setVariable ["tmf_common_ending",true,true];
			}] call cba_fnc_waitUntilAndExecute;
		};
	};
};

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

if (isDedicated) exitWith {};

setTIParameter ["OutputRangeStart", mjb_thermalStart];
setTIParameter ["OutputRangeWidth", mjb_thermalWidth];

private _action =
	[
		"mjb_uniformFix","Fix Uniform",
		"\a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa",
		{ 	 params ["", "_player", ""];
			// will break plates until update
			//[_player,([_player] call CBA_fnc_getLoadout),false] call CBA_fnc_setLoadout;
			_player call mjb_arsenal_fnc_switchUniform;
		},  { true },{ },[],[0,0,0],3,[false, true, false, false, true]
	] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions","ACE_Equipment"], _action, true] call ace_interact_menu_fnc_addActionToClass;

[] call mjb_arsenal_fnc_initStuff;
