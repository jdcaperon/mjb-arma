_loadout = player getVariable "respawnLoadout";	
if (!isNil "_loadout") then {
	player setUnitLoadout _loadout;
};