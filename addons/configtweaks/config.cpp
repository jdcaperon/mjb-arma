class CfgPatches {
  class ConfigTweaks {
    units[] = {};
    weapons[] = {};
    requiredVersion = 0.1;
    author = "SuperJam & Camelith";
    name = "Config Tweaks";
    requiredAddons[] = {
        "A3_Characters_F",
    };
  };
};

// Bullet Resistance Tweaks
class CfgVehicles {
  class Man;
  class CAManBase : Man {
    // total hit points (meaning global "health") of the object keep constant
    // among various soldiers so that the hit points armor coefficients remains
    // on the same scale
    armor = 2;
    // divides all damage taken to total hit point, either directly or through
    // hit point passThrough coefficient. must be adjusted for each model to
    // achieve consistent total damage results
    armorStructural = 3;
    // for consistent explosive damage after adjusting = (armorStructural / 10)
    explosionShielding = 0.3;
    // minimalHit for total damage
    minTotalDamageThreshold = 0.001;
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
        depends =
            "(((Total - 0.25) max 0) + ((HitHead - 0.25) max 0)"
            "+ ((HitBody - 0.25) max 0)) * 2";
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
};
