params ["_projectile"];
private _cached = mjb_cacheWeapon;
if (isNil "_cached" ) then {_cached = [nil,nil,nil,nil,nil];};
private _cacheClasses = _cached # 1;
private _cacheHit = _cached # 2;
private _classHits = _cached # 3;
private _delay = _cached # 4;
_cached = _cached # 0;
private _type = typeOf _projectile;
if (_type isNotEqualTo _cached) then {
	private _config = configOf _projectile;
	if (_projectile isKindOf "MissileBase") exitWith {};
	while {true} do {
		if (_projectile isKindOf "BulletBase") exitWith {_cacheClasses = ["B_40mm_APFSDS","B_20mm","ACE_127x99_API","B_762x51_Ball","B_9x21_Ball"]; _classHits = [150,80,25,11.6,5]; _delay = 0.05; _cacheHit = (getNumber (_config >> "hit"));};
		_delay = 0.25;
		if (_projectile isKindOf "GrenadeBase") exitWith {
			if ((getText (_config >> "simulation")) isEqualTo "shotShell" ) exitWith {
				if ("HEDP" in _type) exitWith {
					_cacheClasses = ["R_MRAAWS_HEAT55_F","R_PG7_F","B_40mm_APFSDS","G_40mm_HEDP","G_20mm_HE"]; _classHits = [140,140,120,100,40];};
				_cacheClasses = ["R_60mm_HE","Sh_120mm_HE","R_TBG32V_F","G_40mm_HE","G_20mm_HE"]; _classHits = [100,90,85,80,40]; _cacheHit = (getNumber (_config >> "indirectHit"));
			};
		};
		if (_projectile isKindOf "RocketBase") exitWith {
				if ("HEAT" in _type || {"PG" in _type}) exitWith {
					_cacheClasses = ["Sh_125mm_HEAT","Sh_125mm_HEAT","R_PG32V_F","R_MRAAWS_HEAT_F","R_PG7_F"]; _classHits = [340,160,150,150,95];}; _cacheHit = getNumber (configFile >> "CfgAmmo" >> (getText (_config >> "submunitionAmmo")) >> "caliber");
				_cacheClasses = ["R_60mm_HE","Sh_120mm_HE","R_TBG32V_F","G_40mm_HE","G_20mm_HE"]; _classHits = [100,90,85,80,40]; _cacheHit = (getNumber (_config >> "indirectHit"));
		};
		if (true) exitWith {};
	};
	//_cacheHit = (getNumber (_config >> "hit")); // remove later, do indirect/caliber for HE/Penetrator
	mjb_cacheWeapon = [_type,_cacheClasses,_cacheHit,_classHits,_delay];
};

sleep _delay;
if (!alive _projectile) exitWith {};
if (isNil "_cacheClasses") exitWith {};
// 0 tank shell, 1 rocket, 2 high cal, 3 rifle, 4 pistol/buck
private _projType = selectRandomWeighted [0,5,1,25,2,125,3,245,4,600];
if (_cacheHit > (_classHits select _projType)) exitWith {};
private _projClass = _cacheClasses select _projType;

private _pos = getPosATL _projectile;
private _vel = velocity _projectile;
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