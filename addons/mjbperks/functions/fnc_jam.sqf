private _range = mjb_fingerRange;
if (_range isEqualTo 0) exitWith {};
private _target = cursorObject;
private _isPerson = _target isKindOf "CAManBase";
if (_isPerson) then {_range = _range + 0.5;};
if !(_isPerson) then {_range = _range + 3;};
if (_target isEqualTo objNull || { !alive _target || {(player distance _target > _range)}}) exitWith {};
[_target, { params ["_target"];
	private _success = true;
	/*private _wep = currentWeapon _target;
	private _muzz = currentMuzzle _target;
	if (isPlayer _target) then {
		private _safedWeapons = _target getVariable ["ace_safemode_safedWeapons", []];
		if (_wep in _safedWeapons) exitWith {
			_success = false;
		};
		[_target, _wep, _muzz] call ace_safemode_fnc_lockSafety;
	} else {*/
		//if (crew _target isNotEqualTo []) then {_target = gunner _target;};
		/*if !(_target checkAIFeature "TARGET") exitWith {
			_success = false;
		};
		_target disableAI "TARGET";
		_target disableAI "WEAPONAIM";
	};*/
	_success = _target reload [];
	if !(_success) exitWith {
		/*private _class = currentMagazine _target;
		if (_class isEqualTo "") exitWith {};
		private _cmd = currentMagazineDetail _target;
		_cmd splitString "([ ]/:)";
		private _mags = magazinesAmmoFull _target;*/
		
	};/*
systemChat "disable";

	[{  params ['_target', '_wep', '_muzz']; systemChat "enable"; if (isPlayer _target) then {[_target, _wep, _muzz] call ace_safemode_fnc_unlockSafety;} else { _target enableAI "TARGET";
		_target enableAI "WEAPONAIM"; };
	},[_target,_wep,_muzz], 4] call CBA_fnc_waitAndExecute;*/
}] remoteExec ["call",_target];