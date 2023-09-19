params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
// perk effects
//mjb_activePerkLoop = [] spawn {};
//private _event = "Fired";
//mjb_activePerkHandler = [ _event, (player addEventHandler [_event, {[player] call mjb_perks_fnc_sneakProjHandler;}] ) ];
private _aDrop =
[
	"aDrop","Ammo Call-in","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\cargoMagAll_ca.paa",
	{   params ["_target"];
		private _pCrate = ("Box_Rats_Ammo" createVehicle (getPos _target));
		private _height = 500;
		if (getTerrainHeightASL (getPosATL _pCrate) <= 0) then {
			_pCrate setPosASL [getPosASL _pCrate select 0, getPosASL _pCrate select 1, _height];
		} else {
			_pCrate setPosATL [getPosATL _pCrate select 0, getPosATL _pCrate select 1, _height];
		};
		_pCrate allowDamage false;
		_pCrate spawn { params ["_crate"];
			[_crate, false] remoteExec ["ace_dragging_fnc_setDraggable",0];
			[_crate, false] remoteExec ["ace_dragging_fnc_setCarryable",0];
			[_crate, 10] remoteExec ["ace_cargo_fnc_setSize",0];
			[{(getPosATL _crate) # 2 > 1 && {(getPosASL _crate) # 2 > 3}}, {_crate setVelocity [0, 0, 0];}, [], 20, {_crate setVelocity [0, 0, 0];}] call CBA_fnc_waitUntilAndExecute;
			[_crate, true] remoteExec ["allowDamage", _crate];
			//mjb_ammoCalled = _crate;
			[_crate, { params ["_crate"];
				_crate addEventHandler ["Killed", {
					params ["_unit"];
					clearItemCargoGlobal _unit;
					clearWeaponCargoGlobal _unit;
					clearBackpackCargoGlobal _unit;
					[_unit, true] call ace_arsenal_fnc_removeBox;
			}];}] remoteExec ["call", 2];
		};
		mjb_ammoDropAvailable = false;
		[{mjb_ammoDropAvailable}, {mjb_ammoDropAvailable = true;}, [], mjb_ammoDropCd, {mjb_ammoDropAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
	},
	{   params ["_target"]; mjb_ammoDropAvailable && { leader _target isEqualTo _target } },
	{ },[],[0,0,0],3,[false, false, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_ammoDropAvailable = true;
[_perkName] call mjb_perks_fnc_updatePerks;