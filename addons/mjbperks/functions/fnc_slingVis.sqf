params ["_unit"];

if (!isNil "mjb_storedWeapon") then {
    [(mjb_storedWeapon select 2),false] remoteExec ["hideObjectGlobal", 2];
    if (!alive _unit) then {
        private _storeWeapon = mjb_storedWeapon;
        deleteVehicle (_storeWeapon # 2);
        private _body = (nearestObjects [_unit, ["WeaponHolderSimulated"], 3]) # 0;
        if (!isNil "_body") exitWith {
            _body addWeaponWithAttachmentsCargoGlobal [(_storeWeapon # 0), 1];
        };
        private _body = ("WeaponHolderSimulated" createVehicle (getPos _unit));
        _body addWeaponWithAttachmentsCargoGlobal [(_storeWeapon # 0), 1];
		private _curPos = getPosASL _body;
		if (_curPos # 2 < 0) then {
		    private _height = (getPosASL _unit) # 2;
		    _body setPosASL [_curPos select 0, _curPos select 1, _height];
			_curPos = getPosATL _body;
		    if (_curPos # 2 < 0) then {
			    _body setPosATL [_curPos select 0, _curPos select 1, 0];
            };
        };
    };
};



