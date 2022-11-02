class CfgPatches {
  class mjb_flags {
    units[] = {"mjb_Flag_RATS_F","Flag_CA_F"/*,"mjb_I_BTR80_RATS","mjb_I_BTR80A_RATS"*/};
    weapons[] = {"mjb_H_Cap_Voin","mjb_H_HelmetSpecB_winter"};
    requiredVersion = 0.1;
    author = "Alien314, Flamebunny, MajorDanvers";
    name = "Flags";
   requiredAddons[]=
		{
			"cba_main"
		};
	};
};

class CfgUnitInsignia
{
	class RATS
	{
		author = "Beagle, Flamebunny";
		displayName = "RATS PMC";
		material = "\A3\ui_f\data\GUI\Cfg\UnitInsignia\default_insignia.rvmat";
		texture = "z\mjb\addons\flags\data\rats_insignia.paa";
	};
};

class CfgMarkers {
	
	class flag_NATO;
	class mjb_flag_RATS : flag_NATO
	{
		icon = "z\mjb\addons\flags\data\rats_ca.paa";
		name = "RATS";
		texture = "z\mjb\addons\flags\data\rats_ca.paa";
	};
	class flag_CA : flag_NATO
	{
		icon = "z\mjb\addons\flags\data\canada_ca.paa";
		name = "CanadaHeightfixed";
		texture = "z\mjb\addons\flags\data\canada_ca.paa";
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
	class FlagCarrier;
	class mjb_Flag_RATS_F : FlagCarrier
	{
		_generalMacro = "mjb_Flag_RATS_F";
		author = "Flamebunny, Alien314";
		displayName = "Flag (RATS)";
		editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\FlagPole_F.jpg";
		hiddenSelectionsMaterials[] = {"\A3\Structures_F\Mil\Flags\Data\Mast_mil.rvmat"};
		hiddenSelectionsTextures[] = {"\A3\Structures_F\Mil\Flags\Data\Mast_mil_CO.paa"};
		scope = 2;
		scopeCurator = 2;
		class EventHandlers
		{
			init = "(_this select 0) setFlagTexture ""\z\mjb\addons\flags\data\ratsFlag_ca.paa""";
		};
	};
	class Flag_CA_F : FlagCarrier
	{
		_generalMacro = "Flag_CA_F";
		author = "Canada";
		displayName = "Flag (Canada)";
		editorPreview = "\A3\EditorPreviews_F\Data\CfgVehicles\FlagPole_F.jpg";
		hiddenSelectionsMaterials[] = {"\A3\Structures_F\Mil\Flags\Data\Mast_mil.rvmat"};
		hiddenSelectionsTextures[] = {"\A3\Structures_F\Mil\Flags\Data\Mast_mil_CO.paa"};
		scope = 2;
		scopeCurator = 2;
		class EventHandlers
		{
			init = "(_this select 0) setFlagTexture ""\z\mjb\addons\flags\data\canadaFlag_ca.paa""";
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
                author = "MajorDanvers, CUP";
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
                author = "MajorDanvers, CUP";
				displayName = "Granmobile";
				textures[] = {"z\mjb\addons\flags\data\granmobile.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\un\bppu_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_BTR80\data\ion\Wheels_co.paa"};
			};
		}
	};
    	
	class CUP_M2Bradley_Base;
	class CUP_B_M2Bradley_USA_D : CUP_M2Bradley_Base
	{
		class textureSources
		{
			class Woodland;
			class RATS : Woodland
			{
                author = "MajorDanvers";
				displayName = "Limebacker";
				textures[] = {"z\mjb\addons\flags\data\cadpat_base.paa","z\mjb\addons\flags\data\cadpat_co.paa","cup\TrackedVehicles\CUP_TrackedVehicles_Bradley\data\ultralp_wdl_co.paa"};
			};
		}
	};
	class CUP_B_M7Bradley_USA_D : CUP_B_M2Bradley_USA_D
	{
		class textureSources
		{
			class Woodland;
			class RATS : Woodland
			{
                author = "MajorDanvers";
				displayName = "Limebacker";
				textures[] = {"z\mjb\addons\flags\data\cadpat_base.paa","z\mjb\addons\flags\data\cadpat_co.paa","cup\TrackedVehicles\CUP_TrackedVehicles_Bradley\data\m7\bfist_wdl_co.paa"};
			};
		}
	};
	class CUP_B_M7Bradley_USA_W : CUP_B_M2Bradley_USA_D
	{
		class textureSources
		{
			class Woodland;
			class RATS : Woodland
			{
                author = "MajorDanvers";
				displayName = "Limebacker";
				textures[] = {"z\mjb\addons\flags\data\cadpat_base.paa","z\mjb\addons\flags\data\cadpat_co.paa","cup\TrackedVehicles\CUP_TrackedVehicles_Bradley\data\m7\bfist_wdl_co.paa"};
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

class CfgWorlds
{
	class CAWorld;
	class Altis : CAWorld
	{
		class Names
		{
			class CapKategidis
			{
				name = "Cape Katgirls";
			};
			class CapThelos
			{
				name = "Cape Katfellows";
			};
		};
	};
};

class CfgWeapons
{
    class H_Cap_red;
    class mjb_H_Cap_Voin : H_Cap_red
    {
        author = "Alien314";
        displayName = "Cap (Voin)";
        hiddenSelectionsTextures[] = {"z\mjb\addons\flags\data\capb_voin_co.paa"};
        picture = "\A3\Characters_F_Bootcamp\Data\UI\icon_H_Cap_oli_ca.paa";
    };

    class H_HelmetSpecB;
    class mjb_H_HelmetSpecB_winter : H_HelmetSpecB
    {
        displayName = "Enhanced Combat Helmet (Winter)";
        hiddenSelectionsTextures[] = {"z\mjb\addons\flags\data\equip1winter_co.paa"};
    };
};