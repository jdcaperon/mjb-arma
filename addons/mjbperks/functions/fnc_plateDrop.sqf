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
private _pDrop =
[
	"pDrop","Plate Call-in","\a3\ui_f\data\gui\rsc\rscdisplayarsenal\vest_ca.paa",
	{   params ["_target"];
		private _pCrate = "Box_Syndicate_Ammo_F" createVehicle (getPos _target);
		private _height = 500;
		if (getTerrainHeightASL (getPosATL _pCrate) <= 0) then {
			_pCrate setPosASL [getPosASL _pCrate select 0, getPosASL _pCrate select 1, _height];
		} else {
			_pCrate setPosATL [getPosATL _pCrate select 0, getPosATL _pCrate select 1, _height];
		};
		clearItemCargoGlobal _pCrate;
		clearMagazineCargoGlobal _pCrate;
		clearWeaponCargoGlobal _pCrate;
		clearBackpackCargoGlobal _pCrate;
		_pCrate allowDamage false;
		_pCrate addItemCargoGlobal ["diw_armor_plates_main_plate", 9];
		_pCrate addItemCargoGlobal ["FirstAidKit", 9];
		if ((_target getUnitTrait 'Medic') && {(mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors}) then {
			_pCrate addItemCargoGlobal ["diw_armor_plates_main_autoInjector", 1];
			mjb_arsenal_injectorStash = mjb_arsenal_injectorStash + 1;
		};
		_pCrate spawn { params ["_crate"];
			[{(getPosATL _crate) # 2 > 1 && {(getPosASL _crate) # 2 > 3}}, {_crate setVelocity [0, 0, 0];}, [], 20, {_crate setVelocity [0, 0, 0];}] call CBA_fnc_waitUntilAndExecute;
		};
		mjb_plateDropAvailable = false;
		[{mjb_plateDropAvailable}, {mjb_plateDropAvailable = true;}, [], mjb_plateDropCd, {mjb_plateDropAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
	},
	{    params ["_target"]; mjb_plateDropAvailable && { leader _target isEqualTo _target || {_target getUnitTrait 'Medic'}} },
	{ },[],[0,0,0],3,[false, false, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _pDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_plateDropAvailable = true;
[_perkName] call mjb_perks_fnc_updatePerks;