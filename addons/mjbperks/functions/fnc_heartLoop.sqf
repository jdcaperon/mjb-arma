private _tracking = [];
private _trackingColor = mjb_heartColor;
if (isNil "diwako_dui_special_track") then {diwako_dui_special_track = [];};

while {true} do {
	if (!isNil "mjb_heartEnd") exitWith {
		{  	diwako_dui_special_track = diwako_dui_special_track - [_x];
			_tracking = _tracking - [_x];
			_x setVariable ["diwako_dui_main_compass_color", nil];
		} forEach _tracking;
		if (diwako_dui_special_track isEqualTo []) then {diwako_dui_special_track = nil};
	};
	private _eyePos = (ASLToAGL (eyePos player));
	private _weapDir = eyeDirection player;
	private _vehicle = vehicle player;
	private _weapon = (currentWeapon _vehicle);
	if ((gunner _vehicle) isNotEqualTo player) then {_weapon = "";};
	if (_weapon isNotEqualTo "") then {_weapDir = (_vehicle weaponDirection _weapon);};
	private _aimpoint = (_eyePos vectorAdd (_weapDir vectorMultiply mjb_heartCenter));
	private _list = ((_aimpoint nearEntities [["CAManBase"],mjb_heartRange]) - (units player));
	{   if (!alive _x || {!(_x in _list)}) then {
		    diwako_dui_special_track = diwako_dui_special_track - [_x];
		    _tracking = _tracking - [_x];
			_x setVariable ["diwako_dui_main_compass_color", nil];
			continue;
		};
		_x setVariable ["diwako_dui_main_compass_color", _trackingColor];
	} forEach _tracking;
	{
		//private _active = _x getVariable ["diwako_dui_main_compass_color", nil];
		//_active = !isNil "_active";
		if (_x in diwako_dui_special_track) then {continue}; //if (_active || {_x in diwako_dui_special_track}) then {continue};
		diwako_dui_special_track = diwako_dui_special_track + [_x];
		_tracking = _tracking + [_x];
		//_x setVariable ["diwako_dui_main_compass_color", _trackingColor];
	} forEach _list;
	sleep 1;
};