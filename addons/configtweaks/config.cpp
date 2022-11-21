class CfgPatches {
  class ConfigTweaks {
    ammo[] = {"mjb_338_NM_trc_gr","mjb_338_NM_trc_ylw","mjb_93x64_trc_gr","mjb_93x64_trc_ylw"};
    magazines[] = {"mjb_150Rnd_93x64_Mag_tracer","mjb_150Rnd_93x64_Mag_trc_red","mjb_150Rnd_93x64_Mag_trc_ylw", "mjb_130Rnd_338_Mag_tracer","mjb_130Rnd_338_Mag_trc_gr","mjb_130Rnd_338_Mag_trc_ylw"/*, "CUP_64Rnd_9x18_Bizon_M","CUP_64Rnd_Green_Tracer_9x18_Bizon_M","CUP_64Rnd_Red_Tracer_9x18_Bizon_M","CUP_64Rnd_White_Tracer_9x18_Bizon_M","CUP_64Rnd_Yellow_Tracer_9x18_Bizon_M"*/};
    units[] = {};
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
            "rhsusf_weapons3"
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
  
  // 3CB
  /* class UK3CB_PKT : rhs_weap_pkt {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
  };
  
  // Bizon mag name fix
  class Rifle_Base_F;
  class CUP_smg_bizon : Rifle_Base_F
  {
      magazineWell[] = {"CBA_9x18_PP19"};
  };
  */
  
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
  
  
  // T1
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
  LIGHTCONFT1(Tier1_X300U,ItemCore);

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
};

#include "CfgAmmo.hpp" // MMG Tracer ammo, (commented Ammo config)
#include "CfgMagazines.hpp" // GreenMag simple compatibility, MMG Tracer boxes
#include "CfgVehicles.hpp"  // BRH for all units/uniforms