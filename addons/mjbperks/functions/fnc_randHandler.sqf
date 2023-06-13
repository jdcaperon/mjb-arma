params ["_projectile"];

sleep 0.05;
if (!alive _projectile) exitWith {};
// 0 tank shell, 1 rocket, 2 high cal, 3 rifle, 4 pistol/buck
private _projType = selectRandomWeighted [0,0.3,1,1.5,2,75,3,500,4,420];

private _projClass = ["Sh_105mm_APFSDS","R_MRAAWS_HEAT_F","ACE_127x99_API","B_556x45_Ball","B_9x21_Ball"] select _projType;

private _pos = getPosATL _projectile;
private _vel = velocity _projectile;
_vel = _vel vectorMultiply (random (2) + 1);
private _dir = vectorDir _projectile;
private _up = vectorUp _projectile;

deleteVehicle _projectile;

private _newProj = createVehicle [_projClass,_pos,[],0,"CAN_COLLIDE"];
_newProj setVectorDirAndUp [_dir,_up];
_newProj setVelocity _vel;
/*

["ace_firedPlayer", { params["", "_weapon", "", "", "", "", "_projectile"];
_projectile addEventHandler ["SubmunitionCreated", {
    params ["","_submunitionProjectile"];
    [_submunitionProjectile] spawn { params ["_projectile"];
sleep 0.05;
if (!alive _projectile) exitWith {};

private _projType = selectRandomWeighted [0,0.1,1,0.2,2,0.8,3,2.4,4,5.0];

private _projClass = ["Sh_105mm_APFSDS","R_MRAAWS_HEAT_F","ACE_127x99_API","B_556x45_Ball","B_9x21_Ball"] select _projType;

private _pos = getPosATL _projectile;
private _vel = velocity _projectile;
private _dir = vectorDir _projectile;
private _up = vectorUp _projectile;

deleteVehicle _projectile;

private _newProj = createVehicle [_projClass,_pos,[],0,"CAN_COLLIDE"];
_newProj setVectorDirAndUp [_dir,_up];
_newProj setVelocity _vel;
    };
}];

if (_weapon isEqualTo "Throw") exitWith {};
    [_projectile] spawn {

params ["_projectile"];
sleep 0.05;
if (!alive _projectile) exitWith {};

private _projType = selectRandomWeighted [0,0.1,1,0.2,2,0.8,3,2.4,4,5.0];

private _projClass = ["Sh_105mm_APFSDS","R_MRAAWS_HEAT_F","ACE_127x99_API","B_556x45_Ball","B_9x21_Ball"] select _projType;

private _pos = getPosATL _projectile;
private _vel = velocity _projectile;
private _dir = vectorDir _projectile;
private _up = vectorUp _projectile;

deleteVehicle _projectile;

private _newProj = createVehicle [_projClass,_pos,[],0,"CAN_COLLIDE"];
_newProj setVectorDirAndUp [_dir,_up];
_newProj setVelocity _vel;

    }
}] call CBA_fnc_addEventHandler;