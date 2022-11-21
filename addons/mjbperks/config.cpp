class CfgPatches {
  class mjb_perks {
	ammo[] = {};
	magazines[] = {};
    units[] = {};//mjb_modulePerks
    weapons[] = {};
    requiredVersion = 0.1;
    author = "Alien314";
    name = "MJB Perks";
    requiredAddons[]=
		{
	   		"ace_interact_menu"
		};
	};
};

class Extended_PostInit_EventHandlers
{
	class mjb_perks
	{
		init="call compileScript ['z\mjb\addons\perks\XEH_postInit.sqf']";
	};
};

class Extended_PreInit_EventHandlers
{
	class mjb_perks
	{
		init="call compileScript ['z\mjb\addons\perks\XEH_preInit.sqf']";
	};
};
class Extended_PreStart_EventHandlers
{
	class mjb_perks
	{
		init="call compileScript ['z\mjb\addons\perks\XEH_preStart.sqf']";
	};
};

class MJB_Perks {
	class mjb_perks_slingState {
		list = "[player]";
		skipNull = 1;

		class Visible {
			onState = "";
			onStateEntered = "";
			onStateLeaving = "";

			class Down {
				targetState = "Hidden";
				condition = "(lifestate _this isEqualTo 'INCAPACITATED') || { vehicle _this isNotEqualTo _this }";
				onTransition = "if (!isNil 'mjb_storedWeapon') then {[(mjb_storedWeapon select 2),true] remoteExec ['hideObjectGlobal', 2]; };";
			};
		};

		class Hidden {
			onState = "";
			onStateEntered = "";
			onStateLeaving = "";
			class NotDown {
				targetState = "Visible";
				condition = "(lifestate _this isNotEqualTo 'INCAPACITATED') && { vehicle _this isEqualTo _this }";
				onTransition = "[_this] call mjb_perks_fnc_slingVis;";
			};
		};
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
    class mjb_modulePerks : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Perks";
        function = "mjb_perks_fnc_modulePerks";
        icon = "\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa";
    };
};*/