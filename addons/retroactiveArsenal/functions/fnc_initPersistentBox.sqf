/*
  How to use:

    If you want persistence between multiple missions, put 'missionGroup = "missionGroupName";' in description.ext for each of the missions.

    Give an object a name in editor or use 'this' from the object's init box.

    Put '[objectName, "varName"] call mjb_arsenal_fnc_initPersistentBox;' in the init.sqf or the container's init box, should work for vehicle inventories as well.

	Be sure you use different varNames for different objects, or the contents of both will be the last one closed.
*/

params [["_crate",objNull,[objNull]], ["_varName",nil,[""]]];

//systemChat str _this;

if (_crate isEqualTo objNull) exitWith {false};

_crate setVariable ["mjb_persistName", _varName];

_crate addEventHandler ["ContainerClosed", {
    params ["_container", ""];
    [_container, (_container getVariable ["mjb_persistName",nil]) ] remoteExec ["mjb_arsenal_fnc_getPersistentBox", 2];
}];

if !(isServer) exitWith {};

[{!(isNil "tmf_common_ending")}, {
	[_container, (_container getVariable ["mjb_persistName",nil]) ] remoteExec ["mjb_arsenal_fnc_getPersistentBox", 2];
}] call cba_fnc_waitUntilAndExecute;

_crate setVariable ["mjb_persistTimer", 
	([_crate, _varName] spawn {
		params ["_unit","_varName"];
		sleep 300;
		while {alive _unit} do {
			[_unit, (_unit getVariable ["mjb_persistName",nil]) ] remoteExec ["mjb_arsenal_fnc_getPersistentBox", 2];
			sleep 300;
		};
	})
];

// _crate allowDamage false;

private _loadbox = (missionProfileNamespace getVariable _varName);
if !(isNil "_loadbox") then {

  clearItemCargoGlobal _crate;
  clearMagazineCargoGlobal _crate;
  clearWeaponCargoGlobal _crate;
  clearBackpackCargoGlobal _crate;

  private _kkohitems = _loadbox # 0;
  private _kkohweaps = _loadbox # 1;
  private _kkohmags = _loadbox # 2;
  private _kkohpacks = _loadbox # 3;
  private _i = 0;
  {
    _crate addItemCargoGlobal [_x, (_kkohitems # 1) # _i];
    _i = _i + 1;
  } forEach _kkohitems # 0;

  _i = 0;
  {
    _crate addWeaponWithAttachmentsCargoGlobal [_x, 1];
    _i = _i + 1;
  } forEach _kkohweaps;

  _i = 0;
  {
    _crate addItemCargoGlobal [_x, (_kkohmags # 1) # _i];
    _i = _i + 1;
  } forEach _kkohmags # 0;

  _i = 0;
  {
    _crate addBackpackCargoGlobal [_x, (_kkohpacks # 1) # _i];
  } forEach _kkohpacks # 0;
};