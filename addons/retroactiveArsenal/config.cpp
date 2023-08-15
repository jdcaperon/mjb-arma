class CfgPatches {
  class mjb_arsenal {
	ammo[] = {};
	magazines[] = {};
    units[] = {"mjb_moduleArsenal","mjb_moduleArsenalMission","mjb_moduleEnd","mjb_moduleResync"};//mjb_modulePersist
    weapons[] = {};
    requiredVersion = 0.1;
    author = "Alien314";
    name = "Retroactive Arsenal";
    requiredAddons[]=
		{
	   		"ace_interact_menu"
		};
	};
};

class Extended_PostInit_EventHandlers
{
	class mjb_arsenal
	{
		init="call compileScript ['z\mjb\addons\arsenal\XEH_postInit.sqf']";
	};
};

class Extended_PreInit_EventHandlers
{
	class mjb_arsenal
	{
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preInit.sqf']";
	};
};
class Extended_PreStart_EventHandlers
{
	class mjb_arsenal
	{
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preStart.sqf']";
	};
};
/*
class CfgWorlds {
	class DefaultWorld { class WaterExPars; };
	class CAWorld : DefaultWorld {
		class WaterExPars : WaterExPars {
			fogColor[] = {0.3,0.07155,0.09045};
		};
	};
};*/



class CfgLoadouts
{
	#include "_macros.hpp"
	class rats {
		category = "RATS";
		displayName = "RATS";
		tooltip = "RATS PMC loadouts.";
		#include "player_loadout.hpp"
	};
	class example_enemy {
		category = "RATS";
		displayName = "xExample Enemy Loadout";
		tooltip = "Loadout example for enemies.";
		#include "enemy_loadout.hpp"
	};
};

class ACEX_Fortify_Presets {
	class rats {
		displayName = "RATS";
		objects[] = {
			{"FootBridge_0_ACR", 5},
			{"Land_Plank_01_4m_F", 5},
			{"Land_tires_EP1", 10},
			{"Land_Tyres_F", 10},
			{"ClutterCutter_small_2_EP1", 10},
			{"TyreBarrier_01_black_F", 15},
			{"Land_Misc_ConcPipeline_EP1", 25},
			{"Land_BagBunker_Small_F", 35},
			{"Land_fort_rampart", 40}
		};
	};
};

class CfgFactionClasses {
    class MJB {
        displayName = "MJB Arma";
        priority = 2;
        side = 7;
    };
};

class CfgVehicles
{
    class Module_F;
	class ModuleEndMission_F;
	//class ModuleEndMission_F : Module_F {
		//function = "mjb_arsenal_fnc_moduleEnd";
	//};
    class mjb_moduleBase : Module_F {
        author = "Alien314";
        category = "MJB";
		curatorCost = 0;
        function = "";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
    };
    class mjb_moduleArsenal : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Retroactive Arsenal";
        function = "mjb_arsenal_fnc_moduleArsenal";
        icon = "\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa";
    };
    class mjb_moduleArsenalMission : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Retroactive Arsenal (Preserve Mission Arsenal)";
        function = "mjb_arsenal_fnc_moduleArsenalMission";
        icon = "\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa";
    };
	class mjb_moduleEnd : ModuleEndMission_F {
        displayName = "End Scenario (No Music/MJB Persistence Save)";
		function = "mjb_arsenal_fnc_moduleEnd";
		icon = "\A3\ui_f\data\igui\cfg\Actions\Obsolete\ui_action_gear_ca.paa";
		portrait = "\A3\ui_f\data\igui\cfg\Actions\Obsolete\ui_action_gear_ca.paa";
		isTriggerActivated = 0;
		scope = 1;
	};
	class mjb_modulePersist : mjb_moduleBase {
        curatorCanAttach = 0;
        displayName = "Activate Persistence (missionGroup/mission)";
		function = "mjb_arsenal_fnc_modulePersist";
		icon = "\A3\ui_f\data\gui\cfg\Hints\Adjust_ca.paa";
        isGlobal = 0;
	};
	class mjb_moduleResync : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Re-Sync Player";
		function = "mjb_arsenal_fnc_moduleResync";
		icon = "\A3\ui_f\data\gui\cfg\Hints\Adjust_ca.paa";
        isGlobal = 0;
	};
};

/*class RscDisplayAttributes;
class RscCheckBox;

class MJB_Display {
	class mjb_rscDisplayAttributesModuleArsenal : RscDisplayAttributes {
		onLoad = "[""onLoad"",_this,""mjb_rscDisplayAttributesModuleArsenal"",'CuratorDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
		onUnload = "[""onUnload"",_this,""mjb_rscDisplayAttributesModuleArsenal"",'CuratorDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
		scriptName = "mjb_rscDisplayAttributesModuleArsenal";
		scriptPath = "CuratorDisplays"; // CfgScriptPaths
		class Controls {
			class CheckBoxJIP : RscCheckBox;
		};
	};
};*/