class CfgPatches {
  class mjb_arsenal {
	ammo[] = {};
	magazines[] = {};
    units[] = {};//"mjb_moduleArsenal"
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
    class mjb_moduleBase : Module_F {
        author = "Alien314";
        category = "MJB";
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
};*/