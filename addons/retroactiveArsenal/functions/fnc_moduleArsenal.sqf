params ["_logic"];

if !(local _logic) exitWith {};

private _unit = attachedTo _logic;
deleteVehicle _logic;


