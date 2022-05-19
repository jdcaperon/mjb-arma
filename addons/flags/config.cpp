class CfgPatches {
  class mjb_flags {
    units[] = {"mjb_Flag_RATS_F","Flag_CA_F","mjb_I_BTR80_RATS","mjb_I_BTR80A_RATS"};
    weapons[] = {};
    requiredVersion = 0.1;
    author = "Alien314, Flamebunny, MajorDanvers";
    name = "Flags";
   requiredAddons[]=
		{
			"cba_main"
		};
	};
};

class CfgMarkers {
	
	class flag_NATO;
	class mjb_flag_RATS : flag_NATO
	{
		icon = "z\mjb\addons\flags\data\ratsFlag_ca.paa";
		name = "RATS";
		texture = "z\mjb\addons\flags\data\ratsFlag_ca.paa";
	};
	class flag_CA : flag_NATO
	{
		icon = "z\mjb\addons\flags\data\canadaFlag_ca.paa";
		name = "CanadaHeightfixed";
		texture = "z\mjb\addons\flags\data\canadaFlag_ca.paa";
	};
};

class CfgFactionClasses 
{
	class mjb_I_RATS 
	{
		displayName = "RATS";
		flag = "z\mjb\addons\flags\data\ratsFlag_ca.paa";
		icon = "z\mjb\addons\flags\data\ratsFlag_ca.paa";
		priority = 9;
		side = 2;
	};
};

class CfgVehicles {
	class FlagPole_F;
	class mjb_Flag_RATS_F : FlagPole_F
	{
		_generalMacro = "mjb_Flag_RATS_F";
		author = "Flamebunny, Alien314";
		displayName = "Flag (RATS)";
		class EventHandlers
		{
			class CBA_Extended_EventHandlers
			{
				init = "call cba_xeh_fnc_init";
			};
		};
	};
	class Flag_CA_F : FlagPole_F
	{
		_generalMacro = "Flag_CA_F";
		displayName = "Flag (Canada)";
		class EventHandlers
		{
			class CBA_Extended_EventHandlers
			{
				init = "call cba_xeh_fnc_init";
			};
		};
	};
	
	
	class CUP_BTR80_Common_Base;
	class CUP_BTR80_Base : CUP_BTR80_Common_Base
	{
		class textureSources
		{
			class ION;
			class RATS : ION
			{
				displayName = "Granmobile";
				textures[] = {"z\mjb\addons\flags\data\granmobile.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\un\kpvt_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\ion\Wheels_co.paa"};
			};
		}
	};
	class CUP_BTR80A_Base : CUP_BTR80_Common_Base
	{
		class textureSources
		{
			class ION;
			class RATS : ION
			{
				displayName = "Granmobile";
				textures[] = {"z\mjb\addons\flags\data\granmobile.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\un\bppu_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\ion\Wheels_co.paa"};
			};
		}
	};
	
	/*class CUP_I_BTR80_ION;
	class mjb_I_BTR80_RATS : CUP_I_BTR80_ION
	{
		faction = "mjb_I_RATS";
		hiddenSelectionsTextures[] = {"z\mjb\addons\flags\data\granmobile.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\un\kpvt_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\ion\Wheels_co.paa"};
	};
	class CUP_I_BTR80A_ION;
	class mjb_I_BTR80A_RATS : CUP_I_BTR80A_ION
	{
		faction = "mjb_I_RATS";
		hiddenSelectionsTextures[] = {"z\mjb\addons\flags\data\granmobile.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\un\bppu_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\ion\Wheels_co.paa"};
	};*/
};

class Extended_Init_EventHandlers
{
	class mjb_Flag_RATS_F
	{
		serverInit = "(_this # 0) setFlagTexture 'z\mjb\addons\flags\data\ratsFlag_ca.paa'";
	};
	class Flag_CA_F
	{
		serverInit = "(_this # 0) setFlagTexture 'z\mjb\addons\flags\data\canadaFlag_ca.paa'";
	};
};