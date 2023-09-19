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
	   		"ace_interact_menu",
			"ace_finger"
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

	class mjb_perks_disChargeState {
		list = "[player]";
		skipNull = 1;

		class Charged {
			onState = "";
			onStateEntered = "mjb_disChargeCdDone = nil; _this addWeaponGlobal (mjb_regDisposable # 0); _this addSecondaryWeaponItem (mjb_regDisposable # 1);";
			onStateLeaving = "";

			class Discharge {
				targetState = "Recharge";
				condition = "private _class = secondaryWeapon _this; (_class isEqualTo '') || {('Used' in (getText (configFile >> 'CfgWeapons' >> _class >> 'displayName'))) || {('used' in (getText (configFile >> 'CfgWeapons' >> _class >> 'displayName'))) } }";
				onTransition = "mjb_disChargeCdDone = false;";
			};
		};

		class Recharge {
			onState = "";
			onStateEntered = "[{mjb_disChargeCdDone = true;},[],mjb_disChargeCd] call CBA_fnc_waitAndExecute;";
			onStateLeaving = "";

			class Charge {
				targetState = "Charged";
				condition = "mjb_disChargeCdDone && {((secondaryWeapon _this) isEqualTo '') || {('Used' in (getText (configFile >> 'CfgWeapons' >> (secondaryWeapon _this) >> 'displayName'))) || {('used' in (getText (configFile >> 'CfgWeapons' >> _class >> 'displayName'))) } } }";
				onTransition = "";
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