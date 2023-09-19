#include "settings.sqf"
[] call mjb_perks_fnc_initStuff;

//*
["CBA_loadoutSet", {
	_this spawn {
    params ["_unit", "", "_extradata"];
    if (mjb_perks) then { 
        private _perks = _extradata getOrDefault ["mjb_perks", []];
		if (!isNil "mjb_activePerks" && { mjb_activePerks isNotEqualTo [] && {_perks isNotEqualTo []}}) then {
			missionNamespace setVariable [("mjb_perkYeet_loadout"),([true, _unit] spawn mjb_perks_fnc_perkCleanup)];
		};
		sleep 1;
		[_perks] call mjb_perks_fnc_updatePerks;
		/*arsenal getVariable ["ace_arsenal_virtualItems", [
			[[], [], []], // Weapons 0, primary 0, secondary 1, handgun 2
			[[], [], [], []], // WeaponAccessories 1, optic 0,side 1,muzzle 2,bipod 3
			[ ], // Magazines 2
			[ ], // Headgear 3
			[ ], // Uniform 4
			[ ], // Vest 5
			[ ], // Backpacks 6
			[ ], // Goggles 7
			[ ], // NVGs 8
			[ ], // Binoculars 9
			[ ], // Map 10
			[ ], // Compass 11
			[ ], // Radio slot 12
			[ ], // Watch slot  13
			[ ], // Comms slot 14
			[ ], // WeaponThrow 15
			[ ], // WeaponPut 16
			[ ]  // InventoryItems 17
		]];*/
		if ("packSling" in _perks) then {
			private _slung = _extradata getOrDefault ["mjb_perks_slung", nil];
			if !(isNil '_slung') then {
				private _slot = (_slung # 1);
				private _weapon = (_slung # 0);
				if (_slot < 0) then {_weapon = (_slung # 3) createVehicle (getPos _unit);};
				private _packWeapon = [_unit, _weapon, _slot] call mjb_perks_fnc_slungWeapon;
				_slung set [2, _packWeapon];
				mjb_storedWeapon = _slung;
			};
		};
		if ("disCharge" in _perks) then {
			mjb_regDisposable = _extradata getOrDefault ["mjb_perks_regd", ["",""]];
		};
    };
	};
}] call CBA_fnc_addEventHandler;

["CBA_loadoutGet", {
    params ["_unit", "", "_extradata"];
    if (mjb_perks) then {
		private _perks = mjb_activePerks;
		_extradata set ["mjb_perks", _perks];
		if (isNil "mjb_persistenceActive" || {(player distance2d (player getVariable ["startpos",[0,0,0]])) > 200}) then {
			if (isNil "arsenal") exitWith {};
			if ("packSling" in _perks) then {
				_extradata set ["mjb_perks_slung", mjb_storedWeapon];
			};
			if ("disCharge" in _perks) then {
				_extradata set ["mjb_perks_regd", mjb_regDisposable];
			};
		};
	};
}] call CBA_fnc_addEventHandler;
//*/
0 spawn { sleep 5;
	private _pointKeybinds = ((["ACE3 Common", "ace_finger_finger"] call CBA_fnc_getKeybind) select 8);
	{	(_x + [{ call mjb_perks_fnc_jam; }, "keydown", "", false]) call CBA_fnc_addKeyHandler;
	} forEach _pointKeybinds;
};