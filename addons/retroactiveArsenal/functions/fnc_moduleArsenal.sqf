params ["_logic"];

private _unit = attachedTo _logic;

if (isNull _unit) exitWith {
	if (isServer) then {
		[true, ""] call mjb_arsenal_fnc_arsenal;
	};

	if !(local _logic) exitWith {};

	deleteVehicle _logic;
};

if (_unit isEqualTo player) then {
	[false, ""] call mjb_arsenal_fnc_arsenal;
};

if !(local _logic) exitWith {};

deleteVehicle _logic;