params ["_perkName", ["_target", player]];

if (typeName _perkName isEqualTo "ARRAY") exitWith {
	{[_target, _target, [_x]] execVM ("z\mjb\addons\perks\functions\fnc_" + _x + ".sqf");} forEach _perkName;
};

mjb_activePerks pushBack _perkName;
mjb_pP = mjb_pP - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);


// banzer line