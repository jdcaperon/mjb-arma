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
  class MGun;
  class LMG_RCWS : MGun {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
    class manual : MGun {};
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
  // HMG_M2 Explicitly overrides aiDispersionCoef in vanilla configs
  // so we can't take advantage of inheritance. Must explicitly override here.
  class HMG_01;
  class HMG_M2 : HMG_01 {
    aiDispersionCoefX = 40.0;
    aiDispersionCoefY = 30.0;
    class manual : MGun {};
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
  class CannonCore;
  class autocannon_Base_F : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
    
  // Disable RHS USAF Vests' forcefield?
	class Default {};
	class ItemCore: Default {};
	class vest_camo_base: ItemCore {};
	class rhsusf_iotv_ocp_base: vest_camo_base {
		class ItemInfo 
		{
			armor = "5*0"; 	// Disable RHS USAF Vests' forcefield?
			               	// CUP does this for Vanilla items, CUP and other RHS vests inherit this from vanilla
					// But RHS USF has this vest set to 20 and it applies to all RHS USF vests
		};
	};
};

#include "CfgAmmo.hpp" // MMG Tracers, (commented Ammo config)
#include "CfgMagazines.hpp" // GreenMag simple compatibility
#include "CfgVehicles.hpp"  // BRH
