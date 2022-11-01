params ["_projectile"];

_projectile addEventHandler ["HitPart", {
    params ["", "_hitEntity"];
    if (!(alive _hitEntity) || {side _hitEntity isEqualTo civilian}) exitWith {};
    if (_hitEntity getVariable ["mjb_killPlate", false]) exitWith {};
    [_hitEntity] spawn {
        params ["_target"];
        _target setVariable ["mjb_killPlate", true];
        sleep 1.5;
        _target setVariable ["mjb_killPlate", nil];
        if (alive _target || {vestContainer player isEqualTo objNull}) exitWith {};
        private _plateCarrier = (vestContainer player);
        private _plates = _plateCarrier getVariable ["diw_armor_plates_main_plates", [0]];
        private _plateCnt = (count _plates - 1) max 0;
        private _topPlate = _plates # _plateCnt;
        if (isNil "_topPlate") then {_topPlate = 0;};
        private _plateMaxHp = diw_armor_plates_main_maxPlateHealth;
        private _plateGain = _plateMaxHp * mjb_plateRegain;
        private _maxPlates = diw_armor_plates_main_numWearablePlates;
        if (_topPlate >= _plateMaxHp) then {_plateCnt = _plateCnt + 1; _topPlate = 0;};
        if (!alive player || {_maxPlates <= _plateCnt}) exitWith {};
        while { _plateGain > 0 && {_plateCnt < _maxPlates}} do {
            _plates set [_plateCnt, ((_plateGain + _topPlate) min _plateMaxHp)];
            _plateGain = _plateGain - (_plateMaxHp - _topPlate);
            _plateCnt = _plateCnt + 1;
            _topPlate = 0;
        };
        _plateCarrier setVariable ["diw_armor_plates_main_plates", _plates];
        [player] call diw_armor_plates_main_fnc_updatePlateUi;
    };
}];
_projectile addEventHandler ["SubmunitionCreated", {
    params ["","_subProj"];
    [_subProj] call mjb_arsenal_fnc_projHandler;
}];

_projectile addEventHandler ["HitExplosion", {
    params ["", "_hitEntity"];
    if (!(alive _hitEntity) || {side _hitEntity isEqualTo civilian}) exitWith {};
    if (_hitEntity getVariable ["mjb_killPlate", false]) exitWith {};
    [_hitEntity] spawn {
        params ["_target"];
        _target setVariable ["mjb_killPlate", true];
        sleep 1.5;
        _target setVariable ["mjb_killPlate", nil];
        if (alive _target || {vestContainer player isEqualTo objNull}) exitWith {};
        private _plateCarrier = (vestContainer player);
        private _plates = _plateCarrier getVariable ["diw_armor_plates_main_plates", [0]];
        private _plateCnt = (count _plates - 1) max 0;
        private _topPlate = _plates # _plateCnt;
        if (isNil "_topPlate") then {_topPlate = 0;};
        private _plateMaxHp = diw_armor_plates_main_maxPlateHealth;
        if (_topPlate >= _plateMaxHp) then {_plateCnt = _plateCnt + 1; _topPlate = 0;};
        if ((_plateCnt + 1) > diw_armor_plates_main_numWearablePlates) exitWith {};
        if (alive player && {_topPlate < _plateMaxHp}) then {
            _topPlate = _topPlate + (_plateMaxHp * mjb_plateRegain);
            _plates set [_plateCnt, (_topPlate min _plateMaxHp)];
            _plateCarrier setVariable ["diw_armor_plates_main_plates", _plates];
            [player] call diw_armor_plates_main_fnc_updatePlateUi;
        };
    };
}];