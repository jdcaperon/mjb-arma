params ["_target","_storeWeapon","_slot"];

if (_slot < 0) exitWith {
	//_storeWeapon enableSimulationGlobal false;
	private _oDir = vectorDir _storeWeapon;
	private _oUp = vectorUp _storeWeapon;
	[_target, _storeWeapon] call ace_dragging_fnc_dropObject_carry;
	_storeWeapon attachTo [_target,[-0.69,-0.26,-0.2], "rightshoulder", true];
	_storeWeapon setVectorDirAndUp [_oDir,_oUp];
	_storeWeapon
};

private _packWeapon = ("GroundWeaponHolder" createVehicle [0,0,0]);
//systemChat str _storeWeapon;
_packWeapon addWeaponWithAttachmentsCargoGlobal [_storeWeapon, 1];
_packWeapon enableSimulationGlobal false;
/*private _slingName = ("mjb_" + (name player) + "Sling");
player setVariable ["mjb_slingName", _slingName];
[[_packWeapon, player], { params ["_slingContainter", "_owner"];
    sleep 0.1;
    if (alive _slingContainter && {alive _owner}) then {
        _slingContainter lockInventory true;
    };
}] remoteExec ["spawn", 0, _slingName]*/
private _handgun = (_slot == 2);
private _loc = [[-0.69,-0.26,-0.2], [-0.8,-0.26,-0.2]] select _handgun;
private _sword = false;
if (_handgun) then { _sword = (isText (configFile >> "CfgWeapons" >> _activeWeapon >> "IMS_WeaponType")); };
if (_sword) then {_loc = [0,0.3,0.2];};
_packWeapon attachTo [_target,_loc, "rightshoulder", true];
private _angle =[ [[0, 1, 0], [-1, 0, 0]] , [[-0.2, 1, -0.1], [-1, 0, 0.1]] ] select (_slot == 1);
_angle = [_angle, [[0, -1, 0], [-1, 0, 0]]] select _handgun; // rather have sword self-impaling than nice pistol placement
if (_sword) then {_angle = [[-0.5, 0.4, -1], [0.5, 0.5, 1]]};
_packWeapon setVectorDirAndUp _angle;

_packWeapon