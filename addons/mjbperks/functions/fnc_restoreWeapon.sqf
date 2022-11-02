private _target = player;
private _storage = mjb_storedWeapon;
private _oldWeapon = (_storage # 0);
private _wepClass = (_oldWeapon # 0);
_oldWeapon = _oldWeapon - [_wepClass];
[_target, _wepClass] call CBA_fnc_addWeaponWithoutItems;
{
    _target addWeaponItem [_wepClass,_x,true];
} forEach _oldWeapon;
deleteVehicle (_storage # 2);
private _muzzle = _storage # 3;
private _firemode = _storage # 4;
_target selectWeapon [_wepClass, _muzzle,_firemode];
mjb_storedWeapon = nil;