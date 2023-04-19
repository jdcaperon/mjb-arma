#include "settings.sqf"
[] call mjb_perks_fnc_initStuff;

/*
["CBA_loadoutSet", {
    params ["_unit", "", "_extradata"];
    if (mjb_perks) then { 
        mjb_activePerks = _extradata getOrDefault ["mjb_perks", []];
    };
}] call CBA_fnc_addEventHandler;

["CBA_loadoutGet", {
    params ["_unit", "", "_extradata"];
    if (mjb_perks) then { _extradata set ["mjb_perks", mjb_activePerks]; };
}] call CBA_fnc_addEventHandler;
//*/