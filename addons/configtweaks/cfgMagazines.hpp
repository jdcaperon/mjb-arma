
class CfgMagazines
{
	class Default {};
	class CA_Magazine: Default {};
	class 30Rnd_556x45_Stanag: CA_Magazine {};

	// MMG Tracer magazines rounds, need to test these
	class 130Rnd_338_Mag: CA_Magazine {};
	class mjb_130Rnd_338_Mag_trc_gr: 130Rnd_338_Mag {
		author = "Alien314";
		ammo = "mjb_338_NM_trc_gr";
		displayName = ".338 Norma Magnum 130Rnd Green Mixed Belt";
		displayNameShort = "Mixed/Green";
	};
	class mjb_130Rnd_338_Mag_trc_ylw: mjb_130Rnd_338_Mag_trc_gr {
		ammo = "mjb_338_NM_trc_ylw";
		displayName = ".338 Norma Magnum 130Rnd Yellow Mixed Belt";
		displayNameShort = "Mixed/Yellow";
	};
	
	class 150Rnd_93x64_Mag: CA_Magazine {};
	class mjb_150Rnd_93x64_Mag_trc_red: 150Rnd_93x64_Mag { 
		author = "Alien314"; 
		ammo = "mjb_93x64_trc_red";
		displayName = "9.3mm 150Rnd Red Mixed Belt";
		displayNameShort = "Mixed/Red";
	};
	class mjb_150Rnd_93x64_Mag_trc_ylw: mjb_150Rnd_93x64_Mag_trc_red {
		ammo = "mjb_93x64_trc_ylw";
		displayName = "9.3mm 150Rnd Yellow Mixed Belt";
		displayNameShort = "Mixed/Yellow";
	};
	
	
// Quick and dirty 'Simple' sim complexity setting only Greenmag compatibility for CUP and RHS
	class CUP_30Rnd_556x45_Stanag: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_25Rnd_556x45_Famas: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_30Rnd_556x45_AK: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_30Rnd_556x45_AK19_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};	
	class CUP_30Rnd_556x45_X95: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};		
	class CUP_35Rnd_556x45_Galil_Mag: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_50Rnd_556x45_Galil_Mag: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_30Rnd_545x39_AK_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_30Rnd_545x39_AK12_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_30Rnd_545x39_Fort224_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd";		
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd";		
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_30Rnd_762x39_AK47_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_30Rnd_762x39_CZ807: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_20Rnd_762x51_DMR: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_20Rnd_762x51_FNFAL_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_762x51_FNFAL_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_20Rnd_762x51_G3: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_20Rnd_762x51_HK417: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_20Rnd_762x51_L129_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_25Rnd_762x51_Galil_Mag: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_762x51_1_B_SCAR: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_762x51_2_B_SCAR: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_50Rnd_762x51_B_SCAR: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_10Rnd_9x19_Compact: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_15Rnd_9x19_M9: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_17Rnd_9x19_M17_Coyote: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_17Rnd_9x19_glock17: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_16Rnd_9x19_cz75: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_9x19_MP5: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_9x19_EVO: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_9x19_UZI: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_9x19_Vityaz: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_9x19AP_Vityaz: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_32Rnd_9x19_TEC9: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_72Rnd_9x19_UZI_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_45ACP_M3A1_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_30Rnd_45ACP_MAC10_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_10Rnd_B_765x17_Ball_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_765x17_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	
	// RHS
	class rhs_mag_30Rnd_556x45_M855A1_Stanag: 30Rnd_556x45_Stanag {};
	class rhs_30Rnd_545x39_AK: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class rhs_30Rnd_545x39_7N6_AK: rhs_30Rnd_545x39_AK {};	
	class rhs_30Rnd_762x39mm: rhs_30Rnd_545x39_7N6_AK
	{
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
	};
	class rhs_20rnd_9x39mm_SP5: rhs_30Rnd_762x39mm
	{
		greenmag_basicammo = "greenmag_ammo_9x39_ball_1Rnd";
	};
	class rhs_100Rnd_762x54mmR: rhs_30Rnd_545x39_7N6_AK
	{
		greenmag_basicammo = "greenmag_beltlinked_762x54_basic";
		greenmag_canSpeedload = 0;
		greenmag_needBelt = 1;
	};
	class rhs_10Rnd_762x54mmR_7N1: rhs_30Rnd_545x39_7N6_AK
	{
		greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
	};	
	class rhs_mag_20Rnd_762x51_m80_fnfal: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};	
	class rhs_mag_20Rnd_SCAR_762x51_m80_ball: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class rhs_mag_9x19_17: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;	
	};
	class rhs_mag_9x18_12_57N181S: rhs_mag_9x19_17
	{
		greenmag_basicammo = "greenmag_ammo_9x18_basic_1Rnd";
	};
	class rhs_18rnd_9x21mm_7N28: rhs_mag_9x19_17
	{
		greenmag_basicammo = "greenmag_ammo_9x21_basic_1Rnd";
	};
	
	// GREF
	class rhsgref_30rnd_556x45_m21: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};	
	class rhsgref_30rnd_556x45_vhs2: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class rhsgref_30rnd_1143x23_M1911B_SMG: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	
	// USF
	class rhsusf_100Rnd_556x45_soft_pouch: rhs_mag_30Rnd_556x45_M855A1_Stanag
	{
		greenmag_ammo = "greenmag_beltlinked_556x45_basic";
		greenmag_basicammo = "greenmag_beltlinked_556x45_basic";
		greenmag_canSpeedload = 0;
		greenmag_needBelt = 1;
	};
	class rhsusf_20Rnd_762x51_m118_special_Mag: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class rhsusf_5Rnd_762x51_m118_special_Mag: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};	
	class rhsusf_10Rnd_762x51_m118_special_Mag: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};	
	class rhsusf_50Rnd_762x51: CA_Magazine
	{
		greenmag_basicammo = "greenmag_beltlinked_762x51_basic";
		greenmag_canSpeedload = 0;
		greenmag_needBelt = 1;		
	};	
	class rhsusf_mag_40Rnd_46x30_AP: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_46x30_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class rhsusf_mag_40Rnd_46x30_FMJ: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_46x30_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};		
	class rhsusf_mag_40Rnd_46x30_JHP: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_46x30_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};	
	class rhsusf_mag_17Rnd_9x19_FMJ: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
};

class CfgMagazineWells {
    class CBA_338NM_LINKS {
        ADDON[] = {
		"mjb_130Rnd_338_Mag_trc_gr",
		"mjb_130Rnd_338_Mag_trc_ylw"
        };
    };
	
    class CBA_93x64_LINKS {
        ADDON[] = {
		"mjb_150Rnd_93x64_Mag_trc_red",
		"mjb_150Rnd_93x64_Mag_trc_ylw"
        };
    };
};
