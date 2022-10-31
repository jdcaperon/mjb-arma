params ["_projectile"];

private _projClass = (typeOf _projectile);
if ("hemlight" in _projClass) then {
    _projectile addEventHandler ["Explode", {
        params ["","_pos"];
        player setPosASL _pos;
    }];
};