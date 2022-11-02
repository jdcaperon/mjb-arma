params ["_projectile"];

_projectile addEventHandler ["SubmunitionCreated", {
    params ["","_submunitionProjectile"];
    private _projClass = (typeOf _submunitionProjectile);
    if ("ellet" in _projClass) then {
        _submunitionProjectile addEventHandler ["HitPart", {
            params ["", "_hitEntity", "_projectileOwner","","","",""];
            if (!(alive _hitEntity) || { !(_hitEntity isKindOf "Man") || {(random 1) > (4/(_projectileOwner distance _hitEntity))} }) exitWith {};
            [_hitEntity,2,_projectileOwner] remoteExec ["ace_fire_fnc_burn", 0];
        }];
    };
}];