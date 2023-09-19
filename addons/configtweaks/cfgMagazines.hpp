#define RND545X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND556X45(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND65X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_650x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND762X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND762X51(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define BELT762X51(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_beltlinked_762x51_basic"; \
		greenmag_canSpeedload = 0; \
		greenmag_needBelt = 1; \
	};
#define RND9X19(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND45ACP(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND65X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_650x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND12G(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_12G_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};

class CfgMagazines
{
	class Default;
	class CA_Magazine : Default { 
		//tracersEvery = 5; // might apply to too many things, vanilla locks down base mags with te0, could make new mags that apply to every gun of a caliber and add them to arsenal
	};
	class 30Rnd_556x45_Stanag : CA_Magazine {};

	// MMG Tracer magazines rounds
	class 130Rnd_338_Mag : CA_Magazine {};
	class mjb_130Rnd_338_Mag_trc_gr: 130Rnd_338_Mag {
		author = "Alien314";
		ammo = "mjb_338_NM_trc_gr";
		displayName = ".338 Norma Magnum 130Rnd Green Mixed Belt";
		displayNameShort = "Mixed/Green";
	};
	class mjb_130Rnd_338_Mag_trc_ylw : mjb_130Rnd_338_Mag_trc_gr {
		ammo = "mjb_338_NM_trc_ylw";
		displayName = ".338 Norma Magnum 130Rnd Yellow Mixed Belt";
		displayNameShort = "Mixed/Yellow";
	};
	
	class 150Rnd_93x64_Mag : CA_Magazine {};
	class mjb_150Rnd_93x64_Mag_trc_red : 150Rnd_93x64_Mag { 
		author = "Alien314"; 
		ammo = "mjb_93x64_trc_red";
		displayName = "9.3mm 150Rnd Red Mixed Belt";
		displayNameShort = "Mixed/Red";
	};
	class mjb_150Rnd_93x64_Mag_trc_ylw : mjb_150Rnd_93x64_Mag_trc_red {
		ammo = "mjb_93x64_trc_ylw";
		displayName = "9.3mm 150Rnd Yellow Mixed Belt";
		displayNameShort = "Mixed/Yellow";
	};

	// fix greenmag error
	class 30Rnd_9x21_Mag;
	class 30Rnd_45ACP_Mag_SMG_01_Tracer_Red : 30Rnd_9x21_Mag {
		ammo = "B_45ACP_Ball_Red";
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
	};
	class 30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow : 30Rnd_9x21_Mag {
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
	};

	RND12G(2Rnd_12Gauge_Pellets,CA_Magazine);
	
// Quick and dirty 'Simple' sim complexity setting only Greenmag compatibility for CUP and RHS
    RND556X45(CUP_30Rnd_556x45_Stanag,CA_Magazine);
    RND556X45(CUP_25Rnd_556x45_Famas,CA_Magazine);
    RND556X45(CUP_30Rnd_556x45_AK,CA_Magazine);
    RND556X45(CUP_30Rnd_556x45_AK19_M,CA_Magazine);
    RND556X45(CUP_30Rnd_556x45_X95,CA_Magazine);
    RND556X45(CUP_35Rnd_556x45_Galil_Mag,CA_Magazine);
    RND556X45(CUP_50Rnd_556x45_Galil_Mag,CA_Magazine);
	
	RND545X39(CUP_30Rnd_545x39_AK_M,CA_Magazine);
	RND545X39(CUP_30Rnd_545x39_AK12_M,CA_Magazine);
	RND545X39(CUP_30Rnd_545x39_Fort224_M,CA_Magazine);
	RND545X39(CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M,CA_Magazine);
	
	RND762X39(CUP_30Rnd_762x39_AK47_M,CA_Magazine);
	RND762X39(CUP_30Rnd_762x39_CZ807,CA_Magazine);
	RND762X39(CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M,CA_Magazine);
	
	RND762X51(CUP_20Rnd_762x51_DMR,CA_Magazine);
	RND762X51(CUP_10Rnd_762x51_FNFAL_M,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_FNFAL_M,CA_Magazine);
	RND762X51(CUP_30Rnd_762x51_FNFAL_M,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_G3,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_HK417,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_L129_M,CA_Magazine);
	RND762X51(CUP_25Rnd_762x51_Galil_Mag,CA_Magazine);
	RND762X51(CUP_30Rnd_762x51_1_B_SCAR,CA_Magazine);
	RND762X51(CUP_30Rnd_762x51_2_B_SCAR,CA_Magazine);
	RND762X51(CUP_50Rnd_762x51_B_SCAR,CA_Magazine);
	RND762X51(CUP_5Rnd_762x51_M24,CA_Magazine);
	RND762X51(CUP_5x_22_LR_17_HMR_M,CA_Magazine);
	RND762X51(CUP_1Rnd_762x51_CZ584,CA_Magazine);
	RND762X51(CUP_10Rnd_762x51_CZ750,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_B_M110,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_B_SCAR,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_CZ805B,CA_Magazine);
	
	class CUP_5Rnd_762x54_Mosin_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_10Rnd_762x54_SVD_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	
	RND9X19(CUP_10Rnd_9x19_Compact,CA_Magazine);
	RND9X19(CUP_15Rnd_9x19_M9,CA_Magazine);
	RND9X19(CUP_17Rnd_9x19_M17_Coyote,CA_Magazine);
	RND9X19(CUP_17Rnd_9x19_glock17,CA_Magazine);
	RND9X19(CUP_16Rnd_9x19_cz75,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_MP5,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_EVO,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_UZI,CA_Magazine);
	RND9X19(CUP_72Rnd_9x19_UZI_M,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_Vityaz,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19AP_Vityaz,CA_Magazine);
	RND9X19(CUP_32Rnd_9x19_TEC9,CA_Magazine);
	RND9X19(CUP_13Rnd_9x19_Browning_HP,CA_Magazine);
	RND9X19(CUP_18Rnd_9x19_Phantom,CA_Magazine);
	
	RND45ACP(CUP_30Rnd_45ACP_M3A1_M,CA_Magazine);
	RND45ACP(CUP_30Rnd_45ACP_MAC10_M,CA_Magazine);
	RND45ACP(CUP_12Rnd_45ACP_mk23,CA_Magazine);
	RND45ACP(CUP_6Rnd_45ACP_M,CA_Magazine);
	RND45ACP(CUP_7Rnd_45ACP_1911,CA_Magazine);
	
	class CUP_10Rnd_B_765x17_Ball_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_765x17_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_10Rnd_127x99_M107: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_127x99_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_5Rnd_127x99_as50_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_127x99_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_5Rnd_127x108_KSVK_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_127x108_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_5Rnd_762x67_G22: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_5Rnd_762x67_M2010_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_5Rnd_TE1_Red_Tracer_762x67_M2010_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_5Rnd_86x70_L115A1: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_338_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};

	RND12G(CUP_5Rnd_B_Saiga12_Buck_00,CA_Magazine);
	RND12G(CUP_5Rnd_B_Saiga12_Slug,CA_Magazine);
	RND12G(CUP_1Rnd_12Gauge_Pellets_No00_Buck,CA_Magazine);
	RND12G(CUP_1Rnd_12Gauge_Slug,CA_Magazine);
	RND12G(CUP_20Rnd_B_AA12_Buck_00,CA_Magazine);
	RND12G(CUP_20Rnd_B_AA12_Slug,CA_Magazine);
	RND12G(CUP_20Rnd_B_AA12_HE,CA_Magazine);
	
	/*/ Bizon class name fix, magwell at bottom
	class CUP_64Rnd_9x19_Bizon_M : CA_Magazine
	{scope = 0};
	class CUP_64Rnd_Green_Tracer_9x19_Bizon_M : CA_Magazine
	{scope = 0};
	class CUP_64Rnd_Red_Tracer_9x19_Bizon_M : CA_Magazine
	{scope = 0};
	class CUP_64Rnd_White_Tracer_9x19_Bizon_M : CA_Magazine
	{scope = 0};
	class CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M : CA_Magazine
	{scope = 0};
	class CUP_64Rnd_9x18_Bizon_M : CUP_64Rnd_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_Green_Tracer_9x18_Bizon_M : CUP_64Rnd_Green_Tracer_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_Red_Tracer_9x18_Bizon_M : CUP_64Rnd_Red_Tracer_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_White_Tracer_9x18_Bizon_M : CUP_64Rnd_White_Tracer_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_Yellow_Tracer_9x18_Bizon_M : CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M
	{scope = 2};*/
	
	// RHS
	class rhs_mag_30Rnd_556x45_M855A1_Stanag: 30Rnd_556x45_Stanag {};
	
	RND545X39(rhs_30Rnd_545x39_AK,CA_Magazine);
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
	RND762X51(rhs_mag_20Rnd_762x51_m80_fnfal,CA_Magazine);
	RND762X51(rhs_mag_20Rnd_SCAR_762x51_m80_ball,CA_Magazine);
	RND9X19(rhs_mag_9x19_17,CA_Magazine);
	class rhs_mag_9x18_12_57N181S: rhs_mag_9x19_17
	{
		greenmag_basicammo = "greenmag_ammo_9x18_basic_1Rnd";
	};
	class rhs_18rnd_9x21mm_7N28: rhs_mag_9x19_17
	{
		greenmag_basicammo = "greenmag_ammo_9x21_basic_1Rnd";
	};
	class rhs_5Rnd_338lapua_t5000: rhs_30Rnd_762x39mm
	{
		greenmag_basicammo = "greenmag_ammo_338_basic_1Rnd";
	};
	
	// GREF
    RND556X45(rhsgref_30rnd_556x45_m21,CA_Magazine);
    RND556X45(rhsgref_30rnd_556x45_vhs2,CA_Magazine);
	
	
	RND45ACP(rhsgref_30rnd_1143x23_M1911B_SMG,CA_Magazine);
	class rhs_mag_762x25_8: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x25_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class rhs_mag_6x8mm_mhp: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x25_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class rhsgref_20rnd_765x17_vz61: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_765x17_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	RND762X51(rhsgref_5Rnd_792x57_kar98k,CA_Magazine);
	class rhsgref_296Rnd_792x57_SmE_belt: CA_Magazine
	{
		greenmag_basicammo = "greenmag_beltlinked_762x51_basic";
		greenmag_canSpeedload = 0;
		greenmag_needBelt = 1;		
	};
	class rhsgref_50Rnd_792x57_SmE_drum: CA_Magazine
	{
		greenmag_basicammo = "greenmag_beltlinked_762x51_basic";
		greenmag_canSpeedload = 0;
		greenmag_needBelt = 1;		
	};
	class rhsgref_25Rnd_792x33_SmE_StG: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class rhsgref_30Rnd_792x33_SmE_StG: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class rhsgref_5Rnd_762x54_m38: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class rhsgref_8Rnd_762x63_M2B_M1rifle: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
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
	RND762X51(rhsusf_20Rnd_762x51_m118_special_Mag,CA_Magazine);
	RND762X51(rhsusf_5Rnd_762x51_m118_special_Mag,CA_Magazine);
	RND762X51(rhsusf_10Rnd_762x51_m118_special_Mag,CA_Magazine);
	RND762X51(rhsusf_50Rnd_762x51,CA_Magazine);
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
	RND9X19(rhsusf_mag_17Rnd_9x19_FMJ,CA_Magazine);
	class 10Rnd_RHS_50BMG_Box: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_127x99_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class rhsusf_5Rnd_300winmag_xm2010: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};	
	RND45ACP(rhsusf_mag_7x45acp_MHP,CA_Magazine);

	RND12G(rhsusf_5Rnd_00Buck,CA_Magazine);
	
	class rhs_mag_30Rnd_556x45_M855A1_EPM;
	class rhs_mag_30Rnd_556x45_M855A1_PMAG;
	class rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan;
	class rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger;
	class rhs_mag_30Rnd_556x45_Mk318_Stanag_Pull;
	
	/*/ Tier 1
	class Tier1_30Rnd_556x45_M855A1_EMag;
	RND762X51(Tier1_20Rnd_762x51_M118_Special_SR25_Mag,CA_Magazine);
	RND65X39(Tier1_20Rnd_65x48_Creedmoor_SR25_Mag,Tier1_20Rnd_762x51_M118_Special_SR25_Mag); // no cal
	RND762X39(Tier1_30Rnd_762x35_300BLK_EMag,Tier1_30Rnd_556x45_M855A1_EMag); // no cal
	
	RND762X39(Tier1_30Rnd_762x35_300BLK_EPM,rhs_mag_30Rnd_556x45_M855A1_EPM); // no cal
	RND762X39(Tier1_30Rnd_762x35_300BLK_PMAG,rhs_mag_30Rnd_556x45_M855A1_PMAG);
	RND762X39(Tier1_30Rnd_762x35_300BLK_PMAG_Tan,rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan);	
	RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_EPM,rhs_mag_30Rnd_556x45_M855A1_EPM);	
	RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_PMAG,rhs_mag_30Rnd_556x45_M855A1_PMAG);
	RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_PMAG_Tan,rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan);	
	RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_Stanag_Ranger,rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger);
	RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_EPM,rhs_mag_30Rnd_556x45_M855A1_EPM);
	RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_PMAG,rhs_mag_30Rnd_556x45_M855A1_PMAG);
	RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_PMAG_Tan,rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan);
	RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_Stanag_Ranger,rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger);	
	RND762X39(Tier1_30Rnd_762x35_300BLK_Stanag,rhs_mag_30Rnd_556x45_M855A1_Stanag);	
	RND762X39(Tier1_30Rnd_762x35_300BLK_Stanag_Pull,rhs_mag_30Rnd_556x45_Mk318_Stanag_Pull);	
	RND762X39(Tier1_30Rnd_762x35_300BLK_Stanag_Ranger,rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger);
	
	BELT762X51(Tier1_100Rnd_762x51_Belt_M61_AP,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_100Rnd_762x51_Belt_M62_Tracer,30Rnd_556x45_Stanag);	
	BELT762X51(Tier1_100Rnd_762x51_Belt_M80,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_100Rnd_762x51_Belt_M80A1_EPR,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_100Rnd_762x51_Belt_M82_Blank,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_100Rnd_762x51_Belt_M993_AP,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_250Rnd_762x51_Belt_M61_AP,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_250Rnd_762x51_Belt_M62_Tracer,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_250Rnd_762x51_Belt_M80,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_250Rnd_762x51_Belt_M80A1_EPR,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_250Rnd_762x51_Belt_M82_Blank,30Rnd_556x45_Stanag);
	BELT762X51(Tier1_250Rnd_762x51_Belt_M993_AP,30Rnd_556x45_Stanag);
	
	RND9X19(Tier1_15Rnd_9x19_FMJ,CA_Magazine);
	RND9X19(Tier1_17Rnd_9x19_P320_FMJ,CA_Magazine);
	RND9X19(Tier1_20Rnd_9x19_FMJ,CA_Magazine);
	RND9X19(Tier1_21Rnd_9x19_P320_FMJ,CA_Magazine);
	RND45ACP(Tier1_15Rnd_40SW_FMJ,CA_Magazine); // no cal
	RND45ACP(Tier1_20Rnd_40SW_FMJ,CA_Magazine);*/
	
	// 3CB
	
	// g3
	// m14
	// fn fal
	// sten
	// mp5
	// 20rnd DMR
	// Enfield

	class rhs_rpg7_PG7V_mag;
	class rhs_rpg7_PG7VL_mag;
	// globmob compat tweak
	//class gm_1Rnd_40mm_heat_pg7v_rpg7 : rhs_rpg7_PG7V_mag {};
	//class gm_1Rnd_40mm_heat_pg7vl_rpg7 : rhs_rpg7_PG7VL_mag {};

	class rhs_VOG25;
	class mjb_vogmdp : rhs_vog25 {
		ammo = "mjb_g_vogmdp";
		displayName = "VOG-MDP";
		descriptionshort = "Type: HEDP Grenade Round<br />Caliber: 40 mm<br />Rounds: 1<br />Used in: GP25";displaynameshort = "HEDP Grenade";
	};
};

class CfgMagazineWells {
    class CBA_338NM_LINKS {
        mjb_mags[] = {
			"mjb_130Rnd_338_Mag_trc_gr",
			"mjb_130Rnd_338_Mag_trc_ylw"
        };
    };
	
    class CBA_93x64_LINKS {
        mjb_mags[] = {
			"mjb_150Rnd_93x64_Mag_trc_red",
			"mjb_150Rnd_93x64_Mag_trc_ylw"
        };
    };
	
    class CBA_40mm_GP {
        mjb_mags[] = {
			"mjb_vogmdp"
        };
		RHS_Magazines[] = {"rhs_VOG25","rhs_VOG25p","rhs_vg40tb","rhs_vg40sz","rhs_vg40op_white","rhs_vg40op_green","rhs_vg40op_red","rhs_GRD40_white","rhs_GRD40_green","rhs_GRD40_red","rhs_VG40MD","rhs_VG40MD_White","rhs_VG40MD_Green","rhs_VG40MD_Red","rhs_GDM40"};
    };
	
    class VOG_40mm {
        mjb_mags[] = {
			"mjb_vogmdp"
        };
    };
	
	/*class CBA_9x18_PP19 
	{
		ADDON[] = {
			"CUP_64Rnd_9x18_Bizon_M","CUP_64Rnd_Green_Tracer_9x18_Bizon_M","CUP_64Rnd_Red_Tracer_9x18_Bizon_M","CUP_64Rnd_White_Tracer_9x18_Bizon_M","CUP_64Rnd_Yellow_Tracer_9x18_Bizon_M"
		};
	};*/
};
