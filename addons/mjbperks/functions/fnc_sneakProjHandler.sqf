params ["_projectile"];

_projectile addEventHandler ["HitPart", {
    params ["", "_hitEntity", "_projectileOwner","","","","_component"];
    if (!(alive _hitEntity) || { !(_hitEntity isKindOf "Man") || {isPlayer _hitEntity || {side _hitEntity isEqualTo civilian}}}) exitWith {};

    private _hitPart = (_component select ((count _component) - 1));
    private _hitString = "hit_" in _hitPart;
    if (_hitString) then {_hitPart = [_hitPart, "hit_", ""] call CBA_fnc_replace;};
    [[_hitEntity,_projectileOwner, _hitPart], { params ["_target", "_shooter", "_hitLoc"];
        if !(combatBehaviour _target in ["AWARE", "COMBAT"]) exitWith {
            [_target, 2, _hitLoc, _shooter] call diw_armor_plates_main_fnc_receiveDamage;};
        private _damage = (4 - (_target knowsAbout _shooter))/2;
        if (_damage > 0) then {
            [_target, _damage, _hitLoc, _shooter] call diw_armor_plates_main_fnc_receiveDamage;};
    }] remoteExec ["call", _hitEntity];
}];
_projectile addEventHandler ["SubmunitionCreated", {
    params ["","_subProj"];
    [_subProj] call mjb_perks_fnc_sneakProjHandler;
}];

_projectile addEventHandler ["HitExplosion", {
    params ["", "_hitEntity", "_projectileOwner"];
    if (!(alive _hitEntity) || { !(_hitEntity isKindOf "Man") || {isPlayer _hitEntity || {side _hitEntity isEqualTo civilian}}}) exitWith {};

    [_hitEntity,_projectileOwner, { params ["_target", "_shooter", "_hitLoc"];
        private _damage = (4 - (_target knowsAbout _shooter))/2;
        if (_damage > 0) then {
            [_target, _damage, "body", _shooter] call diw_armor_plates_main_fnc_receiveDamage;};
    }] remoteExec ["call", _hitEntity];
}];