params ["_hitCheck"];

sleep mjb_plateDelay;
if (_hitCheck isNotEqualTo (player getVariable ["mjb_hitTime", 0])) exitWith {};
private _plateCarrier = (vestContainer player);
if (!alive player || {_plateCarrier isEqualTo objNull}) exitWith {};
private _plates = _plateCarrier getVariable ["diw_armor_plates_main_plates", [0]];
private _plateCnt = (count _plates - 1) max 0;
private _plateMaxHp = diw_armor_plates_main_maxPlateHealth;
private _tickRegen = mjb_plateRegenPerTick;
private _waitTime = (mjb_plateRegenSpeed/_plateMaxHp) * _tickRegen;
//private _tick = 0.1;
private _plateRegenCount = mjb_plateRegenCount;
private _maxPlates = diw_armor_plates_main_numWearablePlates;
while {_plateCnt < _plateRegenCount && {_plateCnt < _maxPlates} } do {
    if ((count _plates - 1) < _plateCnt) then {
        _plates set [_plateCnt, 0];
        _plateCarrier setVariable ["diw_armor_plates_main_plates", _plates];
    };
    private _toughPlate = _plates # _plateCnt;
    while {alive player} do {
        sleep _waitTime;
        if (_hitCheck isNotEqualTo (player getVariable ["mjb_hitTime", 0])) then {break};
        private _plateChk = (_plateCarrier getVariable ["diw_armor_plates_main_plates", [0]]) # _plateCnt;
        if (_plateChk >= _plateMaxHp) then {
            _plates = _plateCarrier getVariable ["diw_armor_plates_main_plates", [0]];
            break
        }; if (_plateChk > _toughPlate) then {_toughPlate = _plateChk};
        _toughPlate = _toughPlate + _tickRegen;
        _plates set [_plateCnt, (_toughPlate min _plateMaxHp)];
        _plateCarrier setVariable ["diw_armor_plates_main_plates", _plates];
        [player] call diw_armor_plates_main_fnc_updatePlateUi;
        if (_toughPlate >= _plateMaxHp) then {break};
    };
    _plateCnt = _plateCnt + 1;
    if (mjb_plateDelayInter) then {
        sleep mjb_plateDelay;
        _plates = _plateCarrier getVariable ["diw_armor_plates_main_plates", [0]];
    };
    if (_hitCheck isNotEqualTo (player getVariable ["mjb_hitTime", 0])) exitWith {};
};