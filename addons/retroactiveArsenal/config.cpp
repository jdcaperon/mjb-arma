class CfgPatches {
  class mjb_arsenal {
	ammo[] = {};
	magazines[] = {};
    units[] = {};
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