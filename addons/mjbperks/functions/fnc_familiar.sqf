params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
};
private _aDrop =
[
	"familiar","Summon Familiar","\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa",
	{   params ["_target"];
		private _pos = ([getPos _target, 6, 20, 6, 0, 0.5, 0] call BIS_fnc_findSafePos);
		if (_pos isEqualTo []) exitWith {systemChat "Suitable summon position not found."};
		private _vicClass = ["CUP_B_Leopard2A6_HIL","CUP_B_M6LineBacker_NATO_T"] select mjb_perks_familiar;
		private _vic = ([_pos, getDir _target, _vicClass, group _target] call BIS_fnc_spawnVehicle);
		private _crew = (_vic select 1);
		_vic = (_vic select 0);
		[[_vic, _crew], {  params ["_vic", "_crew"];
			_vic enableSimulationGlobal false;
			_vic lockCargo true;
			_vic lock true;
			clearItemCargoGlobal _vic;
			clearMagazineCargoGlobal _vic;
			clearWeaponCargoGlobal _vic;
			clearBackpackCargoGlobal _vic;
			if ((typeOf _vic) isEqualTo "CUP_B_M6LineBacker_NATO_T") then {_vic lockCargo false;
				[_vic, "RATS"] call BIS_fnc_initVehicle;
				_vic addWeaponCargoGlobal ["mjb_arifle_C7Alpha", 14];
				_vic addMagazineCargoGlobal ["CUP_30Rnd_556x45_Emag", 28];
				_vic addMagazineCargoGlobal ["CUP_30Rnd_556x45_Emag_Tracer_Yellow", 28];
			};
			_vic enableSimulationGlobal true;
			[{  params ["_vic","_crew"];
				[[_vic,_crew], {  params ["_vic","_crew"];
					{[_x] remoteExec ["deleteVehicle", _x]; waitUntil {_x isEqualTo objNull};} forEach _crew;
					deleteVehicle _vic;
				}] remoteExec ["spawn", _vic];
			}, [_vic, _crew], 180] call CBA_fnc_waitAndExecute;
		}] remoteExec ["call",2];
		mjb_activeFamiliar = _vic;
		mjb_familiarAvailable = false;
		[{mjb_familiarAvailable}, {mjb_familiarAvailable = true;}, [], mjb_familiarCd, {mjb_familiarAvailable = true;}] call CBA_fnc_waitUntilAndExecute;
	},
	{ mjb_familiarAvailable  && {!(alive mjb_activeFamiliar)}},
	{ },[],[0,0,0],3,[false, false, false, false, true]
] call ace_interact_menu_fnc_createAction;
private _addClass = typeOf _target;
private _path = [_addClass, 1, ["ACE_SelfActions"], _aDrop] call ace_interact_menu_fnc_addActionToClass;
missionNamespace setVariable [("mjb_" + _perkName + "ACEAction"),
	[_addClass, 1, _path]
];
mjb_familiarAvailable = true;
mjb_activeFamiliar = objNull;
[_perkName] call mjb_perks_fnc_updatePerks;