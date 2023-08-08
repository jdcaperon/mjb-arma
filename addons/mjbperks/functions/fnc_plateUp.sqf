params ["_target", "_player", "_actionParams"]; _actionParams params ["_perkName"];
if (_perkName in mjb_activePerks) exitWith { 
	if !(isNil ("mjb_perkYeet_" + _perkName)) exitWith {};
	missionNamespace setVariable [("mjb_perkYeet_" + _perkName),([_perkName, _target] spawn mjb_perks_fnc_perkCleanup)];
	[{missionNamespace setVariable [("mjb_perkYeet_" + _this),nil];}, _perkName, 1] call CBA_fnc_waitAndExecute;
	mjb_plateDelay = mjb_plateDelayDefault; mjb_plateDelayDefault = nil;
};
// perk effects
mjb_plateDelayDefault = mjb_plateDelay;
mjb_plateDelay = 0.01;
[_perkName] call mjb_perks_fnc_updatePerks;