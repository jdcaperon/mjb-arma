class CfgPatches {
  class ConfigTweaks {
    units[] = {};
    weapons[] = {};
    requiredVersion = 0.1;
    author = "SuperJam, Camelith, Alien314";
    name = "Config Tweaks";
    requiredAddons[] = {
        "A3_Characters_F",
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

// Bullet Resistance Tweaks
class CfgVehicles {
  class Man;
  class CAManBase : Man {
    // chamatal hit points (meaning global "health") of the object keep constant
    // among various soldiers so that the hit points armor coefficients remains
    // on the same scale
    armor = 2;
    // divides all damage taken to chamatal hit point, either directly or through
    // hit point passThrough coefficient. must be adjusted for each model to
    // achieve consistent chamatal damage results
    armorStructural = 3;
    // for consistent explosive damage after adjusting = (armorStructural / 10)
    explosionShielding = 0.3;
    // minimalHit for chamatal damage
    minChamatalDamageThreshold = 0.001;
    // multiplier for falling damage
    impactDamageMultiplier = 0.5;

    class HitPoints {
      class HitFace {
        // "Healthpoints" of this hitpoint is armor value (of hitpoint) * armor
        // value (coefficient of the total armor defined below for the whole
        // object)
        armor = 5;
        // damage material (-1 means "unused")
        material = -1;
        // selection name from hit points LOD in object
        name = "face_hub";
        // coefficient defining how much damage will pass into  total damage
        // when this hit point is damaged
        passThrough = 0.80000001;
        // size of the hit point sphere, this is how it works:
        // https://community.bistudio.com/wiki/Arma_3_Damage_Description
        radius = 0.079999998;
        // multiplier of explosive damage (parameter: explosive > 0 in
        // ammunition type)
        explosionShielding = 0.1;
        // minimal damage value that can be applied (based on armor value),
        // damage below this threshold is ignored example: total hit point armor
        // = 2 and hitpoint class armor = 10 and minimalHit = 0.04 -> all damage
        // below a hit value of 2*10*0.04 = 0.8 is ignored
        minimalHit = 0.0099999998;
      };
      class HitNeck : HitFace {
        armor = 5;
        material = -1;
        name = "neck";
        passThrough = 0.80000001;
        radius = 0.1;
        explosionShielding = 0.5;
        minimalHit = 0.0099999998;
      };
      class HitHead : HitNeck {
        armor = 5;
        material = -1;
        name = "head";
        passThrough = 0.80000001;
        radius = 0.2;
        explosionShielding = 0.5;
        minimalHit = 0.0099999998;
        // returns the greater of HitFace and HitNeck. for depends to work,
        // HitHead must be inheriting from HitFace and HitNeck. "max" is not the
        // only operator you can use. + and * are confirmed working. Other
        // operators from the
        // https://community.bistudio.com/wiki/Simple_Expression list may be
        // usable as well.
        depends = "HitFace max HitNeck";
      };
      class HitPelvis : HitHead {
        armor = 10;
        material = -1;
        name = "pelvis";
        passThrough = 0.80000001;
        radius = 0.23999999;
        explosionShielding = 1;
        visual = "injury_body";
        minimalHit = 0.0099999998;
        depends = "0";
      };
      class HitAbdomen : HitPelvis {
        armor = 10;
        material = -1;
        name = "spine1";
        passThrough = 0.80000001;
        radius = 0.16;
        explosionShielding = 1;
        visual = "injury_body";
        minimalHit = 0.0099999998;
      };
      class HitDiaphragm : HitAbdomen {
        armor = 10;
        material = -1;
        name = "spine2";
        passThrough = 0.80000001;
        radius = 0.18000001;
        explosionShielding = 6;
        visual = "injury_body";
        minimalHit = 0.0099999998;
      };
      class HitChest : HitDiaphragm {
        armor = 10;
        material = -1;
        name = "spine3";
        passThrough = 0.80000001;
        radius = 0.18000001;
        explosionShielding = 6;
        visual = "injury_body";
        minimalHit = 0.0099999998;
      };
      class HitBody : HitChest {
        armor = 1000;
        material = -1;
        name = "body";
        passThrough = 1;
        radius = 0;
        explosionShielding = 6;
        visual = "injury_body";
        minimalHit = 0.0099999998;
        depends = "HitPelvis max HitAbdomen max HitDiaphragm max HitChest";
      };
      class HitArms : HitBody {
        armor = 65;
        material = -1;
        name = "arms";
        passThrough = 0.55;
        radius = 0.1;
        explosionShielding = 1;
        visual = "injury_hands";
        minimalHit = 0.0099999998;
        depends = "0";
      };
      class HitHands : HitArms {
        armor = 65;
        material = -1;
        name = "hands";
        passThrough = 0.55;
        radius = 0.1;
        explosionShielding = 1;
        visual = "injury_hands";
        minimalHit = 0.0099999998;
        depends = "HitArms";
      };
      class HitLegs : HitHands {
        armor = 65;
        material = -1;
        name = "legs";
        passThrough = 0.40;
        radius = 0.14;
        explosionShielding = 1;
        visual = "injury_legs";
        minimalHit = 0.0099999998;
        depends = "0";
      };
      class Incapacitated : HitLegs {
        armor = 1000;
        material = -1;
        name = "body";
        passThrough = 1;
        radius = 0;
        explosionShielding = 1;
        visual = "";
        minimalHit = 0;
	depends="(((Total - 0.25) max 0) + ((HitHead - 0.25) max 0) + ((HitBody - 0.25) max 0)) * 2";
      };
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
  class auchamacannon_Base_F : CannonCore {
    aiDispersionCoefX = 40;
    aiDispersionCoefY = 30;
  };
  
  
	class Default {};
	class ItemCore: Default {};
	class vest_camo_base: ItemCore {};
	class rhsusf_iotv_ocp_base: vest_camo_base {
		class ItemInfo 
		{
			armor = "5*0";  // Disable RHS USAF Vests' forcefield?
			                // CUP does this for Vanilla items, CUP and other RHS vests inherit this from vanilla
					// But RHS USF has this vest set to 20 and it applies to all RHS USF vests
		};
	};
};


// Quick and dirty Basic ammo only Greenmag compatibility for CUP and RHS
class CfgMagazines
{
	class Default {};
	class CA_Magazine: Default {};
	class 30Rnd_556x45_Stanag: CA_Magazine {};
	
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

/*
// Ammo Balance, spreadsheet with changes: https://docs.google.com/spreadsheets/d/1hBv11wZy6fM9IIj6Qh0-j3qezPhqOBt0XZLNUT1HfvQ/edit#gid=0
// RHS has very different stats for ammo, causing their factions' damage to vary wildly in comparison to Vanilla
// These configs change them to closer match ACE/Vanilla and balance ammos in general
// airFriction: affects bullet drop and damage falloff, 0 is no drop/falloff, -0.001 is ~average
// caliber: how well a bullet penetrates, higher is more penetrative
// hit: base damage of a bullet
// Initial bullet speed is set on magazines with a possible override on weapons, will be much more difficult to change
class CfgAmmo
{
	class Default {};
	class BulletCore: Default {};
	class BulletBase: BulletCore {};
	class B_556x45_Ball: BulletBase	{};
	class B_762x51_Ball: BulletBase	{};
	
	// Vanilla
	class B_12Gauge_Slug: BulletBase
	{
		airFriction = -0.002042; // faster bullet drop/damage falloff
		caliber = 0.54; // less pen, easily destroyed cars before, can still brick engines
		hit = 34.51; // less damage than vanilla
	};
	class B_65x39_Caseless: BulletBase 
	{
		hit = 9.5; // Slight reduction to 6.5, still much stronger than other rifle calibers at range	
	};
	
	
	// CUP	
	class CUP_B_46x30_Ball: BulletBase // MP7 toward RHS values
	{
		caliber = 0.52;
		airFriction = -0.002155;
	};
	
	class CUP_B_545x39_Ball: BulletBase {};
	class CUP_B_545x39_Ball_Subsonic: CUP_B_545x39_Ball // 5.45 subsonic toward RHS
	{
		caliber = 0.34;
		hit = 4;
	};
	class CUP_B_762x39_Ball: BulletBase {};
	class CUP_B_762x39_Ball_Subsonic: CUP_B_762x39_Ball // 7.62x39 subsonic toward RHS
	{
		caliber = 0.455063;
		hit = 5.79;
	};
	class CUP_680x43_Ball_Tracer_Red: B_762x51_Ball
	{
		hit = 10;
	};
	class CUP_12Gauge_Slug: B_12Gauge_Slug
	{
		caliber = 0.54; // inherits everything except caliber
	};
	
	
	// RHS 5.56
	class rhs_ammo_556x45_M193_Ball: B_556x45_Ball
	{
		airFriction = -0.001325;
	};
	class rhs_ammo_556x45_M855_Ball: B_556x45_Ball
	{
		airFriction = -0.001354;
	};
	class rhs_ammo_556x45_M855A1_Ball: B_556x45_Ball
	{
		airFriction = -0.00130094;
	};
	class rhs_ammo_556x45_M995_AP: B_556x45_Ball
	{
		airFriction = -0.00126182;
		caliber = 1.6;
	};
	class rhs_ammo_556x45_Mk262_Ball: B_556x45_Ball
	{
		airFriction = -0.00111805;
		caliber = 0.869;
		hit = 9;
	};
	class rhs_ammo_556x45_Mk318_Ball: B_556x45_Ball
	{
		airFriction = -0.0012588;
		caliber = 0.869;
		hit = 9;
	};	
	
	//RHS Sub/Pistol
	class rhs_ammo_46x30_FMJ: rhs_ammo_556x45_M855A1_Ball
	{
		airFriction = -0.001865;
	};
	class rhs_ammo_46x30_AP: rhs_ammo_46x30_FMJ
	{
		airFriction = -0.002155;
	};
	class rhs_ammo_rhs_ammo_46x30_JHP: rhs_ammo_46x30_FMJ
	{
		airFriction = -0.002635;
	};
	
	// RHS 5.45
	class rhs_B_545x39_Ball: B_556x45_Ball
	{
		hit = 8;
		airFriction = -0.00129458;
		caliber = 0.34;
	};
	class rhs_B_545x39_7N10_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00119458;
		hit = 8.5;
	};
	class rhs_B_545x39_7N22_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00095;
		hit = 8.8;
	};
	class rhs_B_545x39_7N24_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00095;
		hit = 7;
	};
	class rhs_B_545x39_7N6_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00119458;
		caliber = 0.54;
		hit = 8.3;
	};
	class rhs_B_545x39_7U1_Ball: rhs_B_545x39_Ball
	{
		caliber = 0.34;
		hit = 4;
	};
	
	// RHS 7.62x39
	class rhs_B_762x39_Ball: B_762x51_Ball
	{
		airFriction = -0.00150173;
		caliber = 0.928;
		hit = 9.8;
	};
	class rhs_B_762x39_Ball_89: rhs_B_762x39_Ball
	{
		caliber = 1.2;
		hit = 11;
	};
	class rhs_B_762x39_U_Ball: rhs_B_762x39_Ball
	{
		airFriction = -0.0007324;
	};
	
	// RHS 7.62x51
	class rhs_ammo_762x51_M80_Ball: BulletBase
	{
		airFriction = -0.00103711;
		caliber = 1;
	};
	class rhs_ammo_762x51_M118_Special_Ball: rhs_ammo_762x51_M80_Ball
	{
		airFriction = -0.00085147;
		caliber = 1.8;
		hit = 16;
	};
	class rhs_ammo_762x51_M61_AP: rhs_ammo_762x51_M80_Ball
	{
		caliber = 1.9;
	};
	class rhs_ammo_762x51_M80A1EPR_Ball: rhs_ammo_762x51_M80_Ball
	{
		airFriction = -0.00118711;
		caliber = 1.2;
	};
	class rhs_ammo_762x51_M993_Ball: rhs_ammo_762x51_M80_Ball
	{
		airFriction = -0.0010939;
		caliber = 2.2;
		hit = 11;
	};
	class rhs_ammo_762x51_Mk316_Special_Ball: rhs_ammo_762x51_M118_Special_Ball
	{
		airFriction = -0.00084311;
	};
	
	// RHS 12gauge
	class rhs_ammo_12g_slug: B_12Gauge_Slug
	{
		airFriction = -0.002042; // RHS slugs do their own thing
		caliber = 0.54; // for each of these, I kept everything but 
		hit = 34.51; // caliber and applied it to vanilla/CUP
	};	
};
*/
