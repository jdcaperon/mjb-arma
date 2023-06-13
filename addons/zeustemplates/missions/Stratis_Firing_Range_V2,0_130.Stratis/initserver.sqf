// MajorDanvers' Welcome script
[{  
hint format ["Hello %1!", name player];  
 
trace = [ 
    'traceBullets',  
    'Trace bullets',  
    '\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_access_fm_CA.paa',  
    { 
        [player, 1] spawn BIS_fnc_traceBullets; 
        [player, 1, ["ACE_SelfActions"], noTrace] call ace_interact_menu_fnc_addActionToObject; 
        [player, 1, ["ACE_SelfActions", "traceBullets"]] call ace_interact_menu_fnc_removeActionFromObject; 
    },  
    {true} 
] call ace_interact_menu_fnc_createAction; 
 
noTrace = [ 
    'stopTrace',  
    'Stop tracing bullets',  
    '\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_access_fm_CA.paa',  
    { 
        [player, 0] spawn BIS_fnc_traceBullets; 
        [player, 1, ["ACE_SelfActions"], trace] call ace_interact_menu_fnc_addActionToObject; 
        [player, 1, ["ACE_SelfActions", "stopTrace"]] call ace_interact_menu_fnc_removeActionFromObject; 
    },  
    {true} 
] call ace_interact_menu_fnc_createAction; 
 
[player, 1, ["ACE_SelfActions"], trace] call ace_interact_menu_fnc_addActionToObject; 
 
0 = [] spawn { sleep 3; diw_armor_plates_main_timeToAddPlate = 0.5; }; 
 }] remoteExec ['call', ([0,-2] select isDedicated), 'greetings'];

if (!isNil "mjb_arsenal_fnc_serverInit") exitWith {systemChat "Using init from MJB ARMA V2, changes to init scripts in the mission folder will not be reflected. Comment the first line of init scripts you're making changes to."; [] call mjb_arsenal_fnc_serverInit;};

SafestartisActive = true;
publicVariable "SafestartisActive";

// Sim disable non-interactable objects
private _id = ["acex_fortify_objectPlaced", {params ["_player", "_side", "_object"];
  private _interactable = (_object isKindOf "AllVehicles" || {_object isKindOf "ReammoBox" || {_object isKindOf "ThingX"}});
  if (!_interactable) then {_object enableSimulationGlobal false;};
}] call CBA_fnc_addEventHandler;