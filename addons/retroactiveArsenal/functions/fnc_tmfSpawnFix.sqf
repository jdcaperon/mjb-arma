params ["_player"];

//if (!canSuspend) then {_player spawn mjb_arsenal_fnc_tmfSpawnFix};
 private _check = false;
waitUntil {sleep 8; !(isNil {_check = (isPlayer _player); _check}) && {_check}};

[{
    if (isClass (configfile >> "CfgPatches" >> "fatigue_core")) then {
        if(iEnemY_iFatigue_use_sway) then { player setCustomAimCoef iEnemY_iFatigue_aimcoeff; };
        if(iEnemY_iFatigue_stamina_enabled) then { player enableStamina false; };
        if(iEnemY_iFatigue_fatigue_enabled) then { player enableFatigue false; }; 
    };
    player allowSprint true;
    player call diw_armor_plates_main_fnc_fillVestWithPlates;
    player call diw_armor_plates_main_fnc_updatePlateUi;
    if !(isClass(configFile >> "CfgPatches" >> "ace_medical_engine")) then {
        private _maxHp = player getVariable ["diw_armor_plates_main_maxHp", diw_armor_plates_main_maxPlayerHp];
        player setVariable ["diw_armor_plates_main_hp", (_maxHp+0.01), true];
        player call diw_armor_plates_main_fnc_updateHPUi;
    };
    call babe_em_fnc_init;
	if (player isEqualTo tmf_localrespawnedunit) then {[false] call mjb_arsenal_fnc_arsenal;
        player call diw_armor_plates_main_fnc_addPlayerHoldActions; };
}] remoteExec ["call", _player];