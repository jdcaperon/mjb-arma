#define mjb_sitAnims ["amovpsitmstpslowwrfldnon","amovpsitmstpsnonwnondnon_ground","amovpsitmstpsnonwpstdnon_ground"]

player addEventHandler ["AnimChanged", { 
    params ["_unit", "_anim"];	
    if (_anim in mjb_sitAnims) exitWith {         
		if (isDamageAllowed _unit) then {
			_unit allowDamage false;
			mjb_FRenableDamageFlag = true;
		};
    };
    if (!isNil "mjb_FRenableDamageFlag") then {_unit allowDamage true; mjb_FRenableDamageFlag = nil;};
}];

missionNamespace setVariable [("mjb_" + profileName), player, true];

{
	missionNamespace setVariable [_x, true];
} forEach [
	"BIS_respSpecAi",					// Allow spectating of AI
	"BIS_respSpecAllowFreeCamera",		// Allow moving the camera independent from units (players)
	"BIS_respSpecAllow3PPCamera",		// Allow 3rd person camera
	"BIS_respSpecShowFocus",			// Show info about the selected unit (dissapears behind the respawn UI)
	"BIS_respSpecShowCameraButtons",	// Show buttons for switching between free camera, 1st and 3rd person view (partially overlayed by respawn UI)
	"BIS_respSpecShowControlsHelper",	// Show the controls tutorial box
	"BIS_respSpecLists"					// Show list of available units and locations on the left hand side
];

[[player], { params["_unit"];
	_unit addMPEventHandler ["MPRespawn", {
		_unit = _this select 0;
		if (!isPlayer _unit) exitWith {deleteVehicle _unit;};
	}];
}] remoteExec ["call",2];

if (profileName isEqualTo "Eizack") then { [] spawn { waitUntil {cba_missionTime > 1}; leaf setFlagOwner player}};

if (!isNil "mjb_arsenal_fnc_playerLocalInit") exitWith {[] call mjb_arsenal_fnc_playerLocalInit;};

//0 = execVM 'loadouts\arsenal.sqf';
[] call mjb_arsenal_fnc_arsenal;

/* if (SafestartisActive == false) then
{
	[true] call TMF_safestart_fnc_end;
}; */

mjb_startLoc = getPosASL player; // Fix for players falling through platforms on Utes
player setPosASL mjb_startLoc; // Can also be used to teleport players back to start with remoteExec

player switchMove "amovpercmstpslowwrfldnon"; // lower weapon

//workaround for magazines being slurped into weapons
sleep 5;
_primMags = primaryWeaponMagazine player;
if(count _primMags > 0) then {
  player addItem (_primMags select 0);
  if(count _primMags > 1) then {
    player addItem (_primMags select 1);
  };
};
if(secondaryWeapon player != "") then {
  player addItem (secondaryWeaponMagazine player select 0);
};
if(handgunWeapon player != "") then {
  player addItem (handgunMagazine player select 0);
};


/* Commented to let MajorDanvers' welcome script set plate speed
bef_ttap = diw_armor_plates_main_timeToAddPlate; // Credit: MajorDanvers for this block, reduces plating time during safestart
private _plateMachine = [[player], true] call CBA_statemachine_fnc_create;
[_plateMachine, {}, {
    diw_armor_plates_main_timeToAddPlate = 0.5;}, {}, "fast"] call CBA_statemachine_fnc_addState;
[_plateMachine, {}, {
    diw_armor_plates_main_timeToAddPlate = bef_ttap;
	if (time <1290) then {
      player call diw_armor_plates_main_fnc_fillVestWithPlates; // Fill plates in-case anyone forgot
	};
}, {}, "slow"] call CBA_statemachine_fnc_addState;
[_plateMachine, "fast", "slow", {!([] call TMF_safestart_fnc_isActive)}, {}, "Safestart deactivated"] call CBA_statemachine_fnc_addTransition;
[_plateMachine, "slow", "fast", {[] call TMF_safestart_fnc_isActive}, {}, "Safestart active"] call CBA_statemachine_fnc_addTransition;
*/
// credit: Rayle, become invuln while sitting