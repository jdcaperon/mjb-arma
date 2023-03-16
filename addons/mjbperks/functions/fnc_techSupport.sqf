params ["_target"];

private _pos = ([getPos _target, 6, 20, 6, 0, 0.5, 0] call BIS_fnc_findSafePos);
if (_pos isEqualTo []) exitWith {systemChat "Suitable summon position not found."};
private _vicClass = "CUP_B_Hilux_M2_BLU_G_F";
private _vic = _vicClass createVehicle _pos;
clearItemCargoGlobal _vic;
clearMagazineCargoGlobal _vic;
clearWeaponCargoGlobal _vic;
clearBackpackCargoGlobal _vic;
_vic addItemCargoGlobal ["diw_armor_plates_main_plate", 4];
_vic addItemCargoGlobal ["FirstAidKit", 4];
mjb_technical = _vic;
publicVariable "mjb_technical";
mjb_techSuppAvailable = false;
[{mjb_techSuppAvailable}, {mjb_techSuppAvailable = true;}, [], mjb_techSuppCd, {mjb_techSuppAvailable = true;}] call CBA_fnc_waitUntilAndExecute;



