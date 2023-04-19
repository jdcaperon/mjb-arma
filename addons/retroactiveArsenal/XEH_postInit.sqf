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

[] call mjb_arsenal_fnc_initStuff;
