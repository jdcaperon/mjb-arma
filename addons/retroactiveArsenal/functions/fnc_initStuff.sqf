if (mjb_plateToughness) then {
    player addEventHandler ["Hit", {
        player setVariable ["mjb_hitTime", cba_missionTime];
        [cba_missionTime] spawn mjb_arsenal_fnc_toughLoop;
    }];
};

if (mjb_EMfix) then {
	player addEventHandler ["AnimStateChanged", {
		params ["_unit", "_anim"]; 
		if ("babe_" in _anim) then {
			[{  params ["_unit", "_anim"];
				if (getAnimSpeedCoef _unit < EM_default_animspeedcoef) then {
					if (!isNil "mjb_activeEM") exitWith {};
					//if (isServer) then {systemChat ("Probably did an EM. anim: " + _anim);};
					mjb_activeEM = [_anim,getAnimSpeedCoef _unit,EM_default_animspeedcoef];
				};
			},_this,0.1] call CBA_fnc_waitAndExecute;
		};
	}];
	player addEventHandler ["AnimDone", {
		params ["_unit", "_anim"];
		if (!isNil "mjb_activeEM") exitWith {
			mjb_activeEM params ["_oldAnim","_oldSpeed","_defaultSpeed"];
			if (getAnimSpeedCoef _unit < _oldSpeed) exitWith {
				mjb_activeEM set [0,_anim];
				mjb_activeEM set [1,getAnimSpeedCoef _unit];
if (mjb_EMFixDiag) then {
	systemChat (format["You have probably somehow double slowmoded yourself... (speed: %1 / emDefSpeed: %2 / mjbDefSpeed: %3, emVars: %4, anim: %5, prevAnim: %6)", getAnimSpeedCoef _unit ,EM_default_animspeedcoef,_defaultSpeed, (_unit getvariable "babe_em_vars"), _anim, _oldAnim]);
};
			};
			if (_anim isEqualTo _oldAnim) exitWith {[{mjb_activeEM = nil},_this,0.1] call CBA_fnc_execNextFrame;};
			private _babe_em_vars = _unit getvariable "babe_em_vars";
if (mjb_EMFixDiag) then {
	systemChat (format["You might be slowmoded, please screenshot this, fixing. (speed: %1 / emDefSpeed: %2 / mjbDefSpeed: %3, emVars: %4, anim: %5, prevAnim: %6)", getAnimSpeedCoef _unit, EM_default_animspeedcoef,_defaultSpeed, _babe_em_vars, _anim, _oldAnim]);
};
			_babe_em_vars set [0, false];
			_babe_em_vars set [1, false];
			_unit setVariable ["babe_em_vars", _babe_em_vars];

			_unit setAnimSpeedCoef _defaultSpeed;
			mjb_activeEM = nil;
		};
	}];
};

if (mjb_timerRegain > 0) then { [] spawn {
	sleep 1;
	// Credit: MajorDanvers
    diw_armor_plates_main_bleedMachine = [[player], true] call CBA_statemachine_fnc_create;
    private _bleedMachine = diw_armor_plates_main_bleedMachine;
    [_bleedMachine, {}, {diw_armor_plates_main_bleedWait = nil;}, {}, "halt"] call CBA_statemachine_fnc_addState;
    [_bleedMachine, {
        if (!alive player || {player getVariable ["diw_armor_plates_main_unconscious",false]}) exitWith { diw_armor_plates_main_toHalt = true; };
        if (!isNil "diw_armor_plates_main_bleedWait" && {diw_armor_plates_main_bleedWait}) exitWith {};
        private _bleedMalus = diw_armor_plates_main_bleedOutTimeMalus;
        private _bleedPenalty = diw_armor_plates_main_bleedOutTimeSubtraction;
        private _nextRegen = ((diw_armor_plates_main_bleedOutTime - _bleedMalus - _bleedPenalty) / (mjb_timerRegain)) max diw_armor_plates_main_minBleedOutTime;
        if (!isNil "diw_armor_plates_main_bleedWait") then {
                _bleedMalus = _bleedMalus - 1;
                if (_bleedMalus <= (-1 * _bleedPenalty)) exitWith {
                    diw_armor_plates_main_bleedOutTimeMalus = nil};
                diw_armor_plates_main_bleedOutTimeMalus = _bleedMalus;
        };
        diw_armor_plates_main_bleedWait = true;
        [
            { params ["_downed"];
                if (!isNil "diw_armor_plates_main_bleedWait" && {(player getVariable ["mjb_downed",0]) == _downed}) then {diw_armor_plates_main_bleedWait = false;};
            },
            [(player getVariable ["mjb_downed",0])],
            _nextRegen
        ] call CBA_fnc_waitAndExecute;
    }, {}, {}, "recovering"] call CBA_statemachine_fnc_addState;
    //[_bleedMachine, "halt", "recovering", ["diw_armor_plates_main_revive"], {true},{systemChat "activated"}, "Revived"] call CBA_statemachine_fnc_addEventTransition;
    [_bleedMachine, "halt", "recovering", { !(isNil "diw_armor_plates_main_bleedOutTimeMalus") && {!(player getVariable ["diw_armor_plates_main_unconscious",false])} },{player setVariable ["mjb_downed",cba_missionTime]}, "Revived"] call CBA_statemachine_fnc_addTransition;
    //[_bleedMachine, "recovering", "halt", ["diw_armor_plates_main_downed"], {true},{}, "Downed"] call CBA_statemachine_fnc_addEventTransition;
    [_bleedMachine, "recovering", "halt", { isNil "diw_armor_plates_main_bleedOutTimeMalus" }, {}, "Malus fully recovered"] call CBA_statemachine_fnc_addTransition;
    [_bleedMachine, "recovering", "halt", { diw_armor_plates_main_toHalt }, {diw_armor_plates_main_toHalt = false}, "Downed/Killed"] call CBA_statemachine_fnc_addTransition;
}; };

if (mjb_arsenal_maxLoadoutInjectors > 0) then { [] spawn {
	waitUntil {!isNull player};
	if (isNil "mjb_arsenal_injectorCount") then {mjb_arsenal_injectorCount = 0;};	
	mjb_arsenal_injectorStash = 0;

    ["diw_armor_plates_main_consumeInjectorUse", {mjb_arsenal_injectorCount = (mjb_arsenal_injectorCount - 1) max 0;}] call CBA_fnc_addEventHandler;

	sleep 1;
	private _count = 0;
	private _fnc_count = {
		params ["_items", "_amounts"];
		{
			if (_x in diw_armor_plates_main_injectorItems) then {
				_count = _count + (_amounts select _forEachIndex);
			};
		} forEach _items;
	};
    private _unit = player;
	(getItemCargo uniformContainer _unit) call _fnc_count;
	(getItemCargo vestContainer _unit) call _fnc_count;
	(getItemCargo backpackContainer _unit) call _fnc_count;
    mjb_arsenal_injectorCount = _count;

	if (_count > mjb_arsenal_maxLoadoutInjectors) then {
		for "_l" from 1 to (_count - mjb_arsenal_maxLoadoutInjectors) do {
			["diw_armor_plates_main_consumeInjectorUse", [player]] call CBA_fnc_localEvent;
                _count = _count - 1;
                if (_count <= 0) exitWith {};
            };
		    mjb_arsenal_injectorCount = _count max 0;
	};
    if (!isNil "arsenal") then {
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) >= mjb_arsenal_maxLoadoutInjectors) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems; };
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {player getUnitTrait "Medic"}) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems; };
    };

	player addEventHandler ["Put", {
		params ["_unit", "_container", "_item"];
		if !(_item in diw_armor_plates_main_injectorItems) exitWith {};
		mjb_arsenal_injectorStash = mjb_arsenal_injectorStash + 1;
		mjb_arsenal_injectorCount = (mjb_arsenal_injectorCount - 1) max 0;
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) >= mjb_arsenal_maxLoadoutInjectors) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems; };
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {player getUnitTrait "Medic"}) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems; };
	}];

	// needs target event
	player addEventHandler ["Take", {
		params ["_unit", "_container", "_item"];
		if !(_item in diw_armor_plates_main_injectorItems) exitWith {};
		//["", _container] call CBA_fnc_targetEvent;
		if (owner _container == owner _unit) exitWith {};
		mjb_arsenal_injectorStash = (mjb_arsenal_injectorStash - 1) max 0;
        mjb_arsenal_injectorCount = mjb_arsenal_injectorCount + 1;
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) >= mjb_arsenal_maxLoadoutInjectors) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems; };
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {player getUnitTrait "Medic"}) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems; };
		[{ if (isDedicated) exitWith {};
		mjb_arsenal_injectorCount = mjb_arsenal_injectorCount - 1; mjb_arsenal_injectorStash = mjb_arsenal_injectorStash + 1;
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) >= mjb_arsenal_maxLoadoutInjectors) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_removeVirtualItems; };
		if ((mjb_arsenal_injectorCount + mjb_arsenal_injectorStash) < mjb_arsenal_maxLoadoutInjectors && {player getUnitTrait "Medic"}) then {
			[arsenal, diw_armor_plates_main_injectorItems] call ace_arsenal_fnc_addVirtualItems; };}] remoteExec ["call", owner _container]; // ???
	}];
};};