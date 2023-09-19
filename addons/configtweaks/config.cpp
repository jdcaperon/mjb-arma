class CfgPatches {
  class ConfigTweaks {
    ammo[] = {"mjb_338_NM_trc_gr","mjb_338_NM_trc_ylw","mjb_93x64_trc_gr","mjb_93x64_trc_ylw"};
    magazines[] = {"mjb_150Rnd_93x64_Mag_tracer","mjb_150Rnd_93x64_Mag_trc_red","mjb_150Rnd_93x64_Mag_trc_ylw", "mjb_130Rnd_338_Mag_tracer","mjb_130Rnd_338_Mag_trc_gr","mjb_130Rnd_338_Mag_trc_ylw"/*, "CUP_64Rnd_9x18_Bizon_M","CUP_64Rnd_Green_Tracer_9x18_Bizon_M","CUP_64Rnd_Red_Tracer_9x18_Bizon_M","CUP_64Rnd_White_Tracer_9x18_Bizon_M","CUP_64Rnd_Yellow_Tracer_9x18_Bizon_M"*/};
    units[] = {"Box_Rats_Ammo"};
    weapons[] = {};
    requiredVersion = 0.1;
    author = "SuperJam, Camelith, Alien314";
    name = "Config Tweaks";
	requiredAddons[]=
        {
            "ace_ballistics",
            "CUP_Creatures_People_LoadOrder",
            "CUP_Weapons_Ammunition",
            "rhsusf_c_troops",
            "rhs_weapons2",
            "rhs_weapons3",
            "rhsgref_weapons",
            "rhsgref_weapons2",
            "rhsgref_weapons3",
            "rhsusf_weapons2",
            "rhsusf_weapons3",
            "rhs_a2port_air",
            "rhs_a2port_armor",
            "rhs_a2port_car",
            "RHS_US_A2_AirImport",
            "RHS_US_A2Port_Armor",
            "CUP_AirVehicles_LoadOrder",
            "CUP_TrackedVehicles_LoadOrder",
            "CUP_WaterVehicles_LoadOrder",
            "CUP_WheeledVehicles_LoadOrder",
			"PMC_Vest",
			"ace_recoil"
        };
    };
};

// AI Turrets Dispersion Config Tweaks (Built on nkenny's @LAMBS_Turrets)

class CfgBrains {
  class DefaultSoldierBrain {
    class Components {
      class AIBrainAimingErrorComponent {
        maxAngularErrorTurrets =
            0.1308;  // half of the error cone in radians, used for turrets
      };
    };
  };
};

// No greenmag spaghetti tweak
class CfgInventoryGlobalVariable { maxSoldierLoad = 9001; };

class CfgRecoils {
  class recoil_default;
  class recoil_mk200 : recoil_default {
	muzzleOuter[] = {"0.4*0.2","0.6*1", "0.4*1" ,"0.2*1"};
  };
  class recoil_zafir : recoil_default {
	muzzleOuter[] = {"0.5*0.2","1*1", "0.5*1" ,"0.3*1"};
  };
};

class Mode_SemiAuto;
class Mode_FullAuto;

class CfgWeapons {
  class Default;
  class ItemInfo : Default {scope = 1;};
  /*/Zoomy fuck
  class Default {opticsZoomInit = 0.66; opticsZoomMax = 1.5; opticsZoomMin = 0.33;};
  class PistolCore;
  class Pistol : PistolCore {opticsZoomInit = 0.66; opticsZoomMax = 1.5; opticsZoomMin = 0.33;};
  class RifleCore;
  class Rifle : RifleCore {opticsZoomInit = 0.66; opticsZoomMax = 1.5; opticsZoomMin = 0.33;};
  class GrenadeLauncher : Default {opticsZoomInit = 0.66; opticsZoomMax = 1.5; opticsZoomMin = 0.33;};
  class Put : Default {opticsZoomInit = 0.66; opticsZoomMax = 1.5; opticsZoomMin = 0.33;};*/
    
  class MGunCore;
  class MGun : MGunCore {
    class manual;
    class close : manual {
      aiBurstTerminable = 0;
    };
    class short : close {
      aiBurstTerminable = 0;
    };
    class medium : close {
      aiBurstTerminable = 0;
    };
    class far : close {
      aiBurstTerminable = 0;
    };
  };
  class M134_minigun : MGunCore {
    aiDispersionCoefX = 4.0;
    aiDispersionCoefY = 3.0;
  };
  class LMG_RCWS : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class LMG_M200 : LMG_RCWS { };
  // HMG_M2 Explicitly overrides aiDispersionCoef in vanilla configs
  // so we can't take advantage of inheritance. Must explicitly override here.
  class HMG_01;
  class HMG_M2 : HMG_01 {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CannonCore;
  class gatling_30mm_base : CannonCore { };
  class gatling_30mm : gatling_30mm_base { };
  class autocannon_Base_F : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  class autocannon_30mm_CTWS : autocannon_Base_F { };
// Xian autocannon
  
  // CUP
  // FAL Sounds?
  class CUP_Vhmg_DSHKM_veh : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vhmg_KORD_veh : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vhmg_KPVT_veh : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vhmg_PKT_veh : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vhmg_PKT_MGNest : CUP_Vhmg_PKT_veh { };
  class CUP_Vhmg_PKT_veh2 : CUP_Vhmg_PKT_MGNest {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vhmg_PKT_veh3 : CUP_Vhmg_PKT_MGNest {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vlmg_M134_veh : MGun {
    aiDispersionCoefX = 4.0;
    aiDispersionCoefY = 3.0;
  };
  class CUP_Vlmg_M240_veh : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vlmg_M240_nest : CUP_Vlmg_M240_veh {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vlmg_MG3_veh : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class CUP_Vlmg_UK59_veh : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  
  class CUP_Vacannon_2A42_veh : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  class CUP_Vacannon_AK630_veh : CannonCore {
    aiDispersionCoefX = 12;
    aiDispersionCoefY = 9;
  };
  class CUP_Vacannon_M197_veh : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  class CUP_Vacannon_M230_veh : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  class CUP_Vacannon_M242_veh : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  class CUP_Vacannon_M621_AW159_veh : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  
  class PKT : MGun { // ???
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  // RHS
  class RHS_M2 : HMG_M2 { };
  class RHS_M2_offroad : RHS_M2 {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class rhs_weap_DSHKM : LMG_RCWS {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class rhs_weap_kpvt : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class rhs_weap_nsvt : rhs_weap_DSHKM {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class rhs_weap_pkt : PKT {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class rhs_weap_gau21_1 : RHS_M2 {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  class rhs_weap_m240veh : LMG_M200 {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  
  class rhs_weap_azp23 : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  class rhs_weap_2a42_base : autocannon_30mm_CTWS {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };/* Helo nose guns
  class rhs_weap_M197 : gatling_30mm {
    aiDispersionCoefX = 12;
    aiDispersionCoefY = 9;
  };
  class rhs_weap_gi2_base : rhs_weap_M197 {
    aiDispersionCoefX = 12;
    aiDispersionCoefY = 9;
  };*/
  class RHS_weap_M242BC : autocannon_30mm_CTWS {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  
  class Rifle_Base_F;
  // 3CB
  /* class UK3CB_PKT : rhs_weap_pkt {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  
  // Bizon mag name fix
  class CUP_smg_bizon : Rifle_Base_F
  {
      magazineWell[] = {"CBA_9x18_PP19"};
  };
  */
  // Meme MOA
  class CUP_smg_SA61 : Rifle_Base_F {
	class FullAuto : Mode_FullAuto {
		dispersion = 0.02007;
	};
	class Single : Mode_SemiAuto {
		dispersion = 0.02007;
	};
  };

  class greenmag_ammo_127x54_basic_60Rnd;
  class greenmag_ammo_93x64_basic_60Rnd : greenmag_ammo_127x54_basic_60Rnd {
    displayName = "9.3x64mm - 60 Rnd";
    greenmag_ammotype = "greenmag_ammo_93x64_basic_1Rnd";
  };
  class greenmag_ammo_12G_basic_24Rnd : greenmag_ammo_127x54_basic_60Rnd {
    displayName = "12G - 24 Shell";
    greenmag_ammotype = "greenmag_ammo_12G_basic_1Rnd";
	greenmag_bullets = 24;
  };
  class greenmag_ammo_127x54_basic_30Rnd;
  class greenmag_ammo_93x64_basic_30Rnd : greenmag_ammo_127x54_basic_30Rnd {
    displayName = "9.3x64mm - 30 Rnd";
    greenmag_ammotype = "greenmag_ammo_93x64_basic_1Rnd";
  };
  class greenmag_ammo_12G_basic_12Rnd : greenmag_ammo_127x54_basic_30Rnd {
    displayName = "12G - 12 Shell";
    greenmag_ammotype = "greenmag_ammo_12G_basic_1Rnd";
	greenmag_bullets = 12;
  };
  class greenmag_ammo_127x108_basic_1Rnd;
  class greenmag_ammo_12G_basic_1Rnd : greenmag_ammo_127x108_basic_1Rnd {
    displayName = "12G - 1 Shell";
    greenmag_ammotype = "greenmag_ammo_12G_basic_1Rnd";
  };
  
  // Flashlights, special thanks G4rrus
  #define LIGHTCONF(NAME,PARENT) \
  class ##NAME## : ##PARENT## \
  { \
      class ItemInfo : InventoryFlashLightItem_Base_F \
      { \
          class FlashLight \
          { \
              ambient[] = {0.9,0.81,0.7}; \
              color[] = {180,160,130}; \
              coneFadeCoef = 10; \
              direction = "flash"; \
              flareMaxDistance = 300; \
              flareSize = 4; \
              innerAngle = 10; \
              intensity = 4000; \
              outerAngle = 80; \
              position = "flash dir"; \
              scale[] = {0}; \
              class Attenuation \
              { \
                    constant = 32; \
                    hardLimitEnd = 105; \
                    hardLimitStart = 15; \
                    linear = 1; \
                    quadratic = 0.05; \
                    start = 0; \
              }; \
          }; \
      }; \
  };
  #define LIGHTCONFT1(NAME,PARENT) \
  class ##NAME## : ##PARENT## \
  { \
      class ItemInfo : InventoryFlashLightItem_Base_F \
      { \
          class FlashLight \
          { \
              ambient[] = {0.9,0.81,0.7}; \
              color[] = {180,160,130}; \
              coneFadeCoef = 10; \
              direction = "flash_dir"; \
              flareMaxDistance = 300; \
              flareSize = 4; \
              innerAngle = 10; \
              intensity = 4000; \
              outerAngle = 80; \
              position = "flash_pos"; \
              scale[] = {0}; \
              class Attenuation \
              { \
                    constant = 32; \
                    hardLimitEnd = 105; \
                    hardLimitStart = 15; \
                    linear = 1; \
                    quadratic = 0.05; \
                    start = 0; \
              }; \
          }; \
      }; \
  };
  #define LASREQ(NAME,PARENT) \
  class ##NAME## : ##PARENT## \
  { \
      class ItemInfo : InventoryFlashLightItem_Base_F {}; \
  };
  
  class ItemCore;
  class InventoryFlashLightItem_Base_F;
  class FlashLight;
  class acc_flashlight : ItemCore
  {
      class ItemInfo : InventoryFlashLightItem_Base_F
      {
          class FlashLight : FlashLight
          {
              coneFadeCoef = 10;
              flareMaxDistance = 300;
              flareSize = 4;
              innerAngle = 10;
              intensity = 4000;
              outerAngle = 80;
              scale[] = {0};
              class Attenuation
              {
                    constant = 32;
                    hardLimitEnd = 105;
                    hardLimitStart = 15;
                    linear = 1;
                    quadratic = 0.05;
                    start = 0;                
              };
          };
      };
  };
  LIGHTCONF(acc_flashlight_pistol,ItemCore);
  LIGHTCONF(acc_esd_01_flashlight,ItemCore);
  LIGHTCONF(CUP_acc_Flashlight,ItemCore);
  LIGHTCONF(cup_acc_llm01_f,ItemCore);
  LIGHTCONF(cup_acc_llm_flashlight,ItemCore);
  LIGHTCONF(CUP_acc_Glock17_Flashlight,ItemCore);
  LIGHTCONF(cup_acc_cz_m3x,CUP_acc_Flashlight);
  LIGHTCONF(CUP_acc_Zenit_2DS,ItemCore);
  class CUP_acc_ANPEQ_15_Flashlight_Tan_L : ItemCore
  {
      class ItemInfo : InventoryFlashLightItem_Base_F {};
  };
  LASREQ(CUP_acc_ANPEQ_15_Flashlight_Black_L,CUP_acc_ANPEQ_15_Flashlight_Tan_L);
  LASREQ(CUP_acc_ANPEQ_15_Flashlight_OD_L,CUP_acc_ANPEQ_15_Flashlight_Tan_L);
  LIGHTCONF(CUP_acc_ANPEQ_15_Flashlight_Tan_F,CUP_acc_ANPEQ_15_Flashlight_Tan_L);
  LIGHTCONF(CUP_acc_ANPEQ_15_Flashlight_Black_F,CUP_acc_ANPEQ_15_Flashlight_Black_L);
  LIGHTCONF(CUP_acc_ANPEQ_15_Flashlight_OD_F,CUP_acc_ANPEQ_15_Flashlight_OD_L);
  LASREQ(CUP_acc_ANPEQ_15_Top_Flashlight_Black_L,CUP_acc_ANPEQ_15_Flashlight_Tan_L);
  LASREQ(CUP_acc_ANPEQ_15_Top_Flashlight_OD_L,CUP_acc_ANPEQ_15_Flashlight_Tan_L);
  LASREQ(CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L,CUP_acc_ANPEQ_15_Flashlight_Tan_L);
  LIGHTCONF(CUP_acc_ANPEQ_15_Top_Flashlight_Black_F,CUP_acc_ANPEQ_15_Top_Flashlight_Black_L);
  LIGHTCONF(CUP_acc_ANPEQ_15_Top_Flashlight_OD_F,CUP_acc_ANPEQ_15_Top_Flashlight_OD_L);
  LIGHTCONF(CUP_acc_ANPEQ_15_Top_Flashlight_Tan_F,CUP_acc_ANPEQ_15_Top_Flashlight_Tan_L);
  class CUP_acc_ANPEQ_2_Flashlight_Black_L : ItemCore
  {
      class ItemInfo : InventoryFlashLightItem_Base_F {};
  };
  LASREQ(CUP_acc_ANPEQ_2_Flashlight_Coyote_L,CUP_acc_ANPEQ_2_Flashlight_Black_L);
  LASREQ(CUP_acc_ANPEQ_2_Flashlight_OD_L,CUP_acc_ANPEQ_2_Flashlight_Black_L);
  LIGHTCONF(CUP_acc_ANPEQ_2_Flashlight_Black_F,CUP_acc_ANPEQ_2_Flashlight_Black_L);
  LIGHTCONF(CUP_acc_ANPEQ_2_Flashlight_Coyote_F,CUP_acc_ANPEQ_2_Flashlight_Coyote_L);
  LIGHTCONF(CUP_acc_ANPEQ_2_Flashlight_OD_F,CUP_acc_ANPEQ_2_Flashlight_OD_L);
  
  class rhs_acc_2dpZenit : acc_flashlight
  {
      class ItemInfo : InventoryFlashLightItem_Base_F
      {
          class FlashLight : FlashLight
          {
              coneFadeCoef = 10;
              flareMaxDistance = 300;
              flareSize = 4;
              innerAngle = 10;
              intensity = 4000;
              outerAngle = 80;
              scale[] = {0};
              class Attenuation
              {
                    constant = 32;
                    hardLimitEnd = 105;
                    hardLimitStart = 15;
                    linear = 1;
                    quadratic = 0.05;
                    start = 0;                
              };
          };
      };
  };
  class rhs_acc_perst3;
  LASREQ(rhs_acc_perst3_2dp,rhs_acc_perst3);
  class rhs_acc_perst3_2dp_light : rhs_acc_perst3_2dp
  {
      class ItemInfo : InventoryFlashLightItem_Base_F
      {
          class FlashLight : FlashLight
          {
              coneFadeCoef = 10;
              flareMaxDistance = 300;
              flareSize = 4;
              innerAngle = 10;
              intensity = 4000;
              outerAngle = 80;
              scale[] = {0};
              class Attenuation
              {
                    constant = 32;
                    hardLimitEnd = 105;
                    hardLimitStart = 15;
                    linear = 1;
                    quadratic = 0.05;
                    start = 0;                
              };
          };
      };
  };
  class acc_pointer_IR;
  LASREQ(rhsusf_acc_anpeq15,acc_pointer_IR);
  LIGHTCONF(rhsusf_acc_anpeq15_light,rhsusf_acc_anpeq15);
  LIGHTCONF(rhsusf_acc_anpeq15_wmx_light,rhsusf_acc_anpeq15_light);
  LIGHTCONF(rhsusf_acc_anpeq16a_light,rhsusf_acc_anpeq15_light);
  LIGHTCONF(rhsusf_acc_M952V,rhsusf_acc_anpeq15_light);
  LIGHTCONF(rhsusf_acc_wmx,rhsusf_acc_M952V); 
  
  
  /*/ T1
  LIGHTCONFT1(Tier1_10_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_10_LA5_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_10_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_10_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_10_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_10_NGAL_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_10_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_10_NGAL_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_145_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_145_LA5_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_145_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_145_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_145_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_145_NGAL_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_145_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_145_NGAL_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_416_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_416_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_416_LA5_M600V_alt_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_416_LA5_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_416_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_416_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_416_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_M249_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M249_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M249_LA5_M603V_FL,acc_pointer_IR);  
  
  LIGHTCONFT1(Tier1_M300C,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M300C_Black,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_M4BII_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_M4BII_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_NGAL_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M4BII_NGAL_M603V_FL,acc_pointer_IR);  
  
  LIGHTCONFT1(Tier1_M600V,acc_pointer_IR);
  LIGHTCONFT1(Tier1_M600V_Black,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_MCX_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_MCX_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_NGAL_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MCX_NGAL_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_Mk18_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_Mk18_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_NGAL_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk18_NGAL_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_Mk46Mod0_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk46Mod0_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk46Mod0_LA5_M603V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk46Mod1_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk46Mod1_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk46Mod1_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_Mk48Mod0_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk48Mod0_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk48Mod0_LA5_M603V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk48Mod1_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk48Mod1_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_Mk48Mod1_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_MP7_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MP7_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MP7_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MP7_NGAL_M300C_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_MW_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_LA5_M600V_alt_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_LA5_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_MW_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_NGAL_M600V_alt_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_NGAL_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_NGAL_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_MW_NGAL_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_RAHG_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_LA5_M600V_alt_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_LA5_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_RAHG_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_NGAL_M600V_alt_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_NGAL_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_NGAL_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_RAHG_NGAL_M603V_FL,acc_pointer_IR);  
  
  LIGHTCONFT1(Tier1_SCAR_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_SCAR_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_NGAL_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_SCAR_NGAL_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_URX4_LA5_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_LA5_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_LA5_M600V_alt_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_LA5_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_LA5_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_LA5_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_LA5_M603V_FL,acc_pointer_IR);
  
  LIGHTCONFT1(Tier1_URX4_NGAL_M300C_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_NGAL_M300C_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_NGAL_M600V_alt_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_NGAL_M600V_alt_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_NGAL_M600V_Black_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_NGAL_M600V_FL,acc_pointer_IR);
  LIGHTCONFT1(Tier1_URX4_NGAL_M603V_FL,acc_pointer_IR);  
  
  LIGHTCONFT1(tier1_dbalpl_fl,ItemCore);
  LIGHTCONFT1(tier1_tlr1,ItemCore);
  LIGHTCONFT1(Tier1_X300U,ItemCore);*/

  class HeadgearItem;
  #define HATARMOR(NAME,PARENT) \
  class ##NAME## : ##PARENT## \
  { \
    class ItemInfo : HeadgearItem \
    { \
	  class HitpointsProtectionInfo \
  	  { \
		class Head \
		{ \
			hitPointName = "HitHead"; \
			armor = 6; \
			passThrough = 0.5; \
		}; \
	  }; \
    }; \
  };

  HATARMOR(HelmetBase,ItemCore);

  HATARMOR(CUP_H_RUS_Bandana_GSSh_Headphones,ItemCore);
  HATARMOR(CUP_H_RUS_Bandana_HS,ItemCore);
  HATARMOR(CUP_H_FR_BandanaWdl,ItemCore);
  HATARMOR(CUP_H_FR_BoonieWDL,ItemCore);
  HATARMOR(CUP_H_FR_Cap_Headset_Green,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_Burberry,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_Back_Burberry,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_Back_EP_Burberry,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_EP_Burberry,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_PRR_Burberry,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_Back_Grey,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_Back_EP_Grey,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_EP_Grey,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_PRR_Grey,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_Back_tan,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_Back_EP_tan,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_EP_tan,ItemCore);
  HATARMOR(CUP_H_PMC_Cap_PRR_tan,ItemCore);
  HATARMOR(CUP_H_C_Ushanka_01,ItemCore);
  HATARMOR(CUP_H_PMC_PRR_Headset,ItemCore);
  HATARMOR(CUP_H_PMC_Beanie_Headphones_Black,ItemCore);
  HATARMOR(CUP_H_PMC_Beanie_Khaki,ItemCore);
  HATARMOR(CUP_H_PMC_Beanie_Headphones_Khaki,ItemCore);
  HATARMOR(CUP_H_PMC_Beanie_Winter,ItemCore);
  HATARMOR(CUP_H_PMC_Beanie_Headphones_Winter,ItemCore);
  HATARMOR(CUP_H_ChDKZ_Beret,ItemCore);

  class H_Beret_blk : HelmetBase {};
  HATARMOR(CUP_H_SLA_BeretRed,H_Beret_blk);
  HATARMOR(CUP_H_PMC_Beanie_Black,CUP_H_PMC_Beanie_Khaki);
  HATARMOR(CUP_H_C_Beanie_01,ItemCore);

  class H_HelmetB;
  HATARMOR(rhs_beanie,H_HelmetB);
  HATARMOR(rhs_fieldcap_m88,rhs_beanie);
  HATARMOR(rhs_ushanka,rhs_fieldcap_m88);
  HATARMOR(rhsgref_Booniehat_alpen,ItemCore);
  HATARMOR(rhsusf_Bowman,ItemCore);


// Tarkov Vests

  #define VESTLGT(NAME) \
  class ##NAME## : vest_camo_base { \
    class ItemInfo : vestItem { \
      containerClass = "Supply140"; \
      class HitpointsProtectionInfo { \
          class Abdomen {armor = 20; hitpointName = "HitAbdomen"; passThrough = 0.2;}; \
          delete Arms; \
          class Body {hitpointName = "HitBody"; passThrough = 0.2;}; \
          class Chest {armor = 20; hitpointName = "HitChest"; passThrough = 0.2;}; \
          class Diaphragm {armor = 20; hitpointName = "HitDiaphragm"; passThrough = 0.2;}; \
          delete Neck; \
      }; \
    }; \
  };
          /*class Abdomen {armor = 16; hitpointName = "HitAbdomen"; passThrough = 0.3;}; \
          delete Arms; \
          class Body {delete armor; hitpointName = "HitBody"; passThrough = 0.3;}; \
          class Chest {armor = 16; hitpointName = "HitChest"; passThrough = 0.3;}; \
          class Diaphragm {armor = 16; hitpointName = "HitDiaphragm"; passThrough = 0.3;}; \
          delete Neck; \*/

  #define VESTMED(NAME) \
  class ##NAME## : vest_camo_base { \
    class ItemInfo : vestItem { \
      containerClass = "Supply140"; \
      class HitpointsProtectionInfo { \
          class Abdomen {armor = 20; hitpointName = "HitAbdomen"; passThrough = 0.2;}; \
          delete Arms; \
          class Body {hitpointName = "HitBody"; passThrough = 0.2;}; \
          class Chest {armor = 20; hitpointName = "HitChest"; passThrough = 0.2;}; \
          class Diaphragm {armor = 20; hitpointName = "HitDiaphragm"; passThrough = 0.2;}; \
          delete Neck; \
      }; \
    }; \
  };

  #define VESTHEA(NAME) \
  class ##NAME## : vest_camo_base { \
    class ItemInfo : vestItem { \
      containerClass = "Supply120"; \
      class HitpointsProtectionInfo { \
          class Abdomen {armor = 24; hitpointName = "HitAbdomen"; passThrough = 0.1;}; \
          delete Arms; \
          class Body {hitpointName = "HitBody"; passThrough = 0.1;}; \
          class Chest {armor = 24; hitpointName = "HitChest"; passThrough = 0.1;}; \
          class Diaphragm {armor = 24; hitpointName = "HitDiaphragm"; passThrough = 0.1;}; \
          delete Neck; \
      }; \
    }; \
  };

  #define VESTHVY(NAME) \
  class ##NAME## : vest_camo_base { \
    class ItemInfo : vestItem { \
      containerClass = "Supply100"; \
      class HitpointsProtectionInfo { \
          class Abdomen {armor = 24; hitpointName = "HitAbdomen"; passThrough = 0.1;}; \
          class Arms {armor = 8; hitpointName = "HitArms"; passThrough = 0.5;}; \
          class Body {hitpointName = "HitBody"; passThrough = 0.1;}; \
          class Chest {armor = 24; hitpointName = "HitChest"; passThrough = 0.1;}; \
          class Diaphragm {armor = 24; hitpointName = "HitDiaphragm"; passThrough = 0.1;}; \
          class Neck {armor = 8; hitpointName = "HitNeck"; passThrough = 0.5;}; \
      }; \
    }; \
  };

  class vest_camo_base;
  class Vest_NoCamo_Base;
  class vestItem;

  VESTLGT(V_PlateCarrier1_blk);
  class V_PlateCarrier1_rgr : Vest_NoCamo_Base {
    class ItemInfo : vestItem {
      containerClass = "Supply140";
      class HitpointsProtectionInfo {
          class Abdomen {armor = 20; hitpointName = "HitAbdomen"; passThrough = 0.2;};
          class Body {hitpointName = "HitBody"; passThrough = 0.2;};
          class Chest {armor = 20; hitpointName = "HitChest"; passThrough = 0.2;};
          class Diaphragm {armor = 20; hitpointName = "HitDiaphragm"; passThrough = 0.2;};
      };
    };
  };

  VESTMED(6B3_vest);
  VESTMED(6b5Flora);
  VESTMED(6b5Khaki_vest);
  VESTMED(A18_vest);
  VESTMED(AVS_vest);

  VESTMED(Def2_vest);
  VESTMED(def2Assault_vest);
  VESTMED(def2Bearing_vest);
  VESTMED(def2BlackRock_vest);
  VESTMED(def2D3CRX_vest);
  VESTMED(def2MK3_vest);
  VESTMED(def2Thunderbolt_vest);
  VESTMED(def2Triton_vest);
  VESTMED(def2TV109_vest);

  VESTMED(Gjel_vest);
  VESTMED(GjelAssault_vest);
  VESTMED(GjelBearing_vest);
  VESTMED(GjelBlackRock_vest);
  VESTMED(GjelD3CRX_vest);
  VESTMED(GjelMK3_vest);
  VESTMED(GjelThunderbolt_vest);
  VESTMED(GjelTriton_vest);
  VESTMED(GjelTV109_vest);

  VESTMED(KorundVMAssault_vest);
  VESTMED(KorundVMBearing_vest);
  VESTMED(KorundVMBlackRock_vest);
  VESTMED(KorundVMD3CRX_vest);
  VESTMED(korundvm_vest);
  VESTMED(KorundVMMK3_vest);
  VESTMED(KorundVMThunderbolt_vest);
  VESTMED(KorundVMTriton_vest);
  VESTMED(KorundVMTV109_vest);

  VESTMED(M1_vest);
  VESTMED(M2_vest);
  VESTMED(TV110_vest);

  VESTMED(Thorcrv_vest);
  VESTMED(ThorcrvAssault_vest);
  VESTMED(ThorcrvBearing_vest);
  VESTMED(ThorcrvBlackRock_vest);
  VESTMED(ThorcrvD3CRX_vest);
  VESTMED(ThorcrvMK3_vest);
  VESTMED(ThorcrvThunderbolt_vest);
  VESTMED(ThorcrvTriton_vest);
  VESTMED(ThorcrvTV109_vest);


  VESTMED(Trooper_vest);
  VESTMED(TrooperAssault_vest);
  VESTMED(TrooperBearing_vest);
  VESTMED(TrooperBlackRock_vest);
  VESTMED(TrooperD3CRX_vest);
  VESTMED(TrooperMK3_vest);
  VESTMED(TrooperThunderbolt_vest);
  VESTMED(TrooperTriton_vest);
  VESTMED(TrooperTV109_vest);

  VESTLGT(Module3m_vest);
  VESTLGT(Module3mAssault_vest);
  VESTLGT(Module3mBearing_vest);
  VESTLGT(Module3mBlackRock_vest);
  VESTLGT(Module3mD3CRX_vest);
  VESTLGT(Module3mMK3_vest);
  VESTLGT(Module3mThunderbolt_vest);
  VESTLGT(Module3mTriton_vest);
  VESTLGT(Module3mTV109_vest);

  VESTHEA(RedutM_vest);
  VESTHEA(RedutMAssault_vest);
  VESTHEA(RedutMBearing_vest);
  VESTHEA(RedutMBlackRock_vest);
  VESTHEA(RedutMD3CRX_vest);
  VESTHEA(RedutMMK3_vest);
  VESTHEA(RedutMThunderbolt_vest);
  VESTHEA(RedutMTriton_vest);
  VESTHEA(RedutMTV109_vest);

  VESTHEA(Slick_vest);
  VESTHEA(SlickAssault_vest);
  VESTHEA(SlickBearing_vest);
  VESTHEA(SlickBlackRock_vest);
  VESTHEA(SlickD3CRX_vest);
  VESTHEA(SlickMK3_vest);
  VESTHEA(SlickThunderbolt_vest);
  VESTHEA(SlickTriton_vest);
  VESTHEA(SlickTV109_vest);
};

/*class CfgSounds {
  class 3den_notificationWarning {
    sound[] = {"\a3\3DEN\Data\Sound\CfgSound\notificationWarning",0.85,1};
  };
};*/

#include "CfgAmmo.hpp" // MMG Tracer ammo, (commented Ammo config)
#include "CfgMagazines.hpp" // GreenMag simple compatibility, MMG Tracer boxes
#include "CfgVehicles.hpp"  // BRH for all units/uniforms