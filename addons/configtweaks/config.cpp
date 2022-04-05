class CfgPatches {
  class ConfigTweaks {
	ammo[] = {"mjb_338_NM_trc_gr","mjb_338_NM_trc_ylw","mjb_93x64_trc_gr","mjb_93x64_trc_ylw"};
	magazines[] = {"mjb_150Rnd_93x64_Mag_tracer","mjb_150Rnd_93x64_Mag_trc_red","mjb_150Rnd_93x64_Mag_trc_ylw", "mjb_130Rnd_338_Mag_tracer","mjb_130Rnd_338_Mag_trc_gr","mjb_130Rnd_338_Mag_trc_ylw"};
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
  */
};

#include "CfgAmmo.hpp" // MMG Tracer ammo, (commented Ammo config)
#include "CfgMagazines.hpp" // GreenMag simple compatibility, MMG Tracer boxes
#include "CfgVehicles.hpp"  // BRH for all units/uniforms
