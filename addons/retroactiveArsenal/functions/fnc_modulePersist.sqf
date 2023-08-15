if !(local _logic) exitWith {};

deleteVehicle _logic;

private _persist = (missionNamespace getVariable ["mjb_persistenceActive",false]);
if (_persist) exitWith { };

["mjb_modulePersist",[],"mjb_modulePersistence"] call CBA_fnc_globalEventJIP;