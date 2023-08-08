params ["_target"];

if !(canSuspend) exitWith {_this spawn mjb_perks_fnc_pSling};

private _weapons = [primaryWeapon _target, secondaryWeapon _target, handgunWeapon _target, binocular _target];
sleep 0.1;
private _prev = isNil "mjb_storedWeapon";
private _occupied = false;
private _slotCheck = 3;
private _exit = false;
if (!_prev) then {
    _slotCheck = (mjb_storedWeapon # 1);
    if (_slotCheck >= 0 && {_weapons # _slotCheck isNotEqualTo ""}) then {_occupied = true;};
    if (!_occupied) exitWith {
        _exit = true;
        call mjb_perks_fnc_restoreWeapon;
    };
};
if (_exit) exitWith {};
private _activeWeapon = [(currentWeapon _target), (_weapons # _slotCheck)] select _occupied;
private _hasWeapon = (_activeWeapon isNotEqualTo "");
private _carrying = (_target getVariable ["ace_dragging_isCarrying", false]);
if (_prev && {!_hasWeapon && {!_carrying}}) exitWith {};
if (_hasWeapon) exitWith {
	private _slot = _weapons findIf {_x isEqualTo _activeWeapon};
	_weapons = weaponsItems _target;
	private _muzzleMode = weaponState _target;
	_muzzleMode = [_muzzleMode # 1,_muzzleMode # 2];
	private _storeWeapon = _weapons select (_weapons findIf {(_x # 0) isEqualTo _activeWeapon});
	if (_hasWeapon) then {[_target] call ace_weaponselect_fnc_putWeaponAway; sleep 2; _target removeWeapon _activeWeapon;};
	if (_occupied) then {
		call mjb_perks_fnc_restoreWeapon;
	};
	if (!_hasWeapon) exitWith {};
	private _packWeapon = [_target, _storeWeapon, _slot] call mjb_perks_fnc_slungWeapon;
	/*private _packWeapon = ("GroundWeaponHolder" createVehicle [0,0,0]);
	_packWeapon addWeaponWithAttachmentsCargoGlobal [_storeWeapon, 1];
	_packWeapon enableSimulationGlobal false;
	/*private _slingName = ("mjb_" + (name player) + "Sling");
	player setVariable ["mjb_slingName", _slingName];
	[[_packWeapon, player], { params ["_slingContainter", "_owner"];
		sleep 0.1;
		if (alive _slingContainter && {alive _owner}) then {
			_slingContainter lockInventory true;
		};
	}] remoteExec ["spawn", 0, _slingName]/
	private _handgun = (_slot == 2);
	private _loc = [[-0.69,-0.26,-0.2], [-0.8,-0.26,-0.2]] select _handgun;
	private _sword = false;
	if (_handgun) then { _sword = (isText (configFile >> "CfgWeapons" >> _activeWeapon >> "IMS_WeaponType")); };
	if (_sword) then {_loc = [0,0.3,0.2];};
	_packWeapon attachTo [_target,_loc, "rightshoulder", true];
	private _angle =[ [[0, 1, 0], [-1, 0, 0]] , [[-0.2, 1, -0.1], [-1, 0, 0.1]] ] select (_slot == 1);
	_angle = [_angle, [[0, -1, 0], [-1, 0, 0]]] select _handgun; // rather have sword self-impaling than nice pistol placement
	if (_sword) then {_angle = [[-0.5, 0.4, -1], [0.5, 0.5, 1]]};
	_packWeapon setVectorDirAndUp _angle;*/
	_packWeapon setDamage [1,false];
	mjb_storedWeapon = [_storeWeapon, _slot, _packWeapon] + _muzzleMode;
};
private _carried = (_target getVariable ["ace_dragging_carriedObject", objNull]);
if (_carried isEqualTo objNull || {_carried isKindOf "CAManBase"}) exitWith {};
private _slot = -1;
private _muzzleMode = [typeOf _carried,""];
private _packWeapon = [_target, _carried, _slot] call mjb_perks_fnc_slungWeapon;
//_packWeapon setDamage [1,false];
mjb_storedWeapon = [_carried, _slot, _packWeapon] + _muzzleMode;