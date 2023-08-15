params ["_unit","_weapon","_projectile"];


if (_weapon isNotEqualTo "Throw") exitWith {};
private _projClass = (typeOf _projectile);
if ("hemlight" in _projClass) then {
    _projectile setVariable ["mjb_tpUnit", _unit];
    _projectile addEventHandler ["Explode", {
        params ["_projectile","_pos"];
        (_projectile getVariable ["mjb_tpUnit", objNull]) setPosASL _pos;
		if (mjb_teleFix) then {
			_projectile setVariable ["mjb_tpUnit", nil];
			_projectile removeEventHandler [_thisEvent,_thisEventHandler];
		};
    }];
};