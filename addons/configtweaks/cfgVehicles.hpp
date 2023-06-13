class CfgVehicles {
  /*/ Bullet Resistance Tweaks
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
        passThrough = 0.8;
        // size of the hit point sphere, this is how it works:
        // https://community.bistudio.com/wiki/Arma_3_Damage_Description
        radius = 0.08;
        // multiplier of explosive damage (parameter: explosive > 0 in
        // ammunition type)
        explosionShielding = 0.1;
        // minimal damage value that can be applied (based on armor value),
        // damage below this threshold is ignored example: total hit point armor
        // = 2 and hitpoint class armor = 10 and minimalHit = 0.04 -> all damage
        // below a hit value of 2*10*0.04 = 0.8 is ignored
        minimalHit = 0.01;
      };
      class HitNeck : HitFace {
        armor = 5;
        material = -1;
        name = "neck";
        passThrough = 0.8;
        radius = 0.1;
        explosionShielding = 0.5;
        minimalHit = 0.01;
      };
      class HitHead : HitNeck {
        armor = 5;
        material = -1;
        name = "head";
        passThrough = 0.8;
        radius = 0.2;
        explosionShielding = 0.5;
        minimalHit = 0.01;
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
        passThrough = 0.8;
        radius = 0.24;
        explosionShielding = 1;
        visual = "injury_body";
        minimalHit = 0.01;
        depends = "0";
      };
      class HitAbdomen : HitPelvis {
        armor = 10;
        material = -1;
        name = "spine1";
        passThrough = 0.8;
        radius = 0.16;
        explosionShielding = 1;
        visual = "injury_body";
        minimalHit = 0.01;
      };
      class HitDiaphragm : HitAbdomen {
        armor = 10;
        material = -1;
        name = "spine2";
        passThrough = 0.8;
        radius = 0.18;
        explosionShielding = 6;
        visual = "injury_body";
        minimalHit = 0.01;
      };
      class HitChest : HitDiaphragm {
        armor = 10;
        material = -1;
        name = "spine3";
        passThrough = 0.8;
        radius = 0.18;
        explosionShielding = 6;
        visual = "injury_body";
        minimalHit = 0.01;
      };
      class HitBody : HitChest {
        armor = 1000;
        material = -1;
        name = "body";
        passThrough = 1;
        radius = 0;
        explosionShielding = 6;
        visual = "injury_body";
        minimalHit = 0.01;
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
        minimalHit = 0.01;
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
        minimalHit = 0.01;
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
        minimalHit = 0.01;
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
  
  class Civilian: CAManBase {};
  class Civilian_F: Civilian {};
  
  // NATO
  class SoldierWB: CAManBase {};
  class B_Soldier_base_F: SoldierWB {};
  class B_Soldier_04_f: B_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  class B_Soldier_05_f: B_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  
  // Ind
  class SoldierGB: CAManBase {};
  class I_Soldier_base_F: SoldierGB { armorStructural = 3; explosionShielding = 0.3; };
  class I_Soldier_03_F: I_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  class I_Soldier_04_F: I_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
    // Contact
  class I_E_Man_Base_F: I_Soldier_base_F {};
  class I_E_Uniform_01_coveralls_F: I_E_Man_Base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  
  // CSAT
  class SoldierEB: CAManBase {};
  class O_Soldier_base_F: SoldierEB {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  class O_V_Soldier_Base_F: O_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  class O_officer_F: O_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  class O_Soldier_diver_base_F: O_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };
  class O_Soldier_02_F: O_Soldier_base_F {
    armorStructural = 3;
    explosionShielding = 0.3;

    class HitPoints {
      class HitFace { armor = 5; };
      class HitNeck : HitFace { armor = 5; };
      class HitHead : HitNeck { armor = 5; };
      class HitPelvis : HitHead { armor = 10; };
      class HitAbdomen : HitPelvis { armor = 10; };
      class HitDiaphragm : HitAbdomen { armor = 10; explosionShielding = 6; };
      class HitChest : HitDiaphragm { armor = 10; explosionShielding = 6; };
      class HitBody : HitChest { explosionShielding = 6; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; explosionShielding = 1;
      };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40;explosionShielding = 1;
      };
    };
  };

  // CUP
  class CUP_Creatures_Civil_Chernarus_Base: Civilian_F {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Civil_Takistan_Base: Civilian_F {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_BAF_Soldier_DDPM_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_BAF_Soldier_DPM_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_BAF_Soldier_MTP_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_ACR_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_CDF_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_FR_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_GER_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_HIL_Man_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_HIL_Recon_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_HIL_Reservist_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_HIL_SF_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_NAPA_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_OPFINS_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_PMC_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_PMC_Soldier_Winter_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_RACS_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_RUS_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_SLA_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_TK_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_TKG_Guerrilla_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_TKI_Insurgent_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_UNO_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_USA_Soldier_ACU_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_USA_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
  class CUP_Creatures_Military_USMC_Soldier_Base: SoldierWB {
    class HitPoints {
      class HitFace { armor = 5; passThrough = 0.8; };
      class HitNeck : HitFace { armor = 5; passThrough = 0.8; };
      class HitHead : HitNeck { armor = 5; passThrough = 0.8;};
      class HitPelvis : HitHead { armor = 10; passThrough = 0.8; radius = 0.24; depends = "0"; };
      class HitAbdomen : HitPelvis { armor = 10; passThrough = 0.8; radius = 0.16; };
      class HitDiaphragm : HitAbdomen { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitChest : HitDiaphragm { armor = 10; passThrough = 0.8; radius = 0.18; };
      class HitBody : HitChest { passThrough = 1; radius = 0; };
      class HitArms : HitBody { armor = 65; passThrough = 0.55; depends = "0"; };
      class HitHands : HitArms { armor = 65; passThrough = 0.55; depends = "HitArms"; };
      class HitLegs : HitHands { armor = 65; passThrough = 0.40; radius = 0.14; depends = "0"; 
	  };
    };
  };
//*/

  #define PACKPLUS(PARENT,NAME,DISPLAYNAME) \
  class ##PARENT##; \
  class ##NAME## : ##PARENT## { \
    displayName = ##DISPLAYNAME##; \
    maximumLoad = 350; \
  };

  PACKPLUS(B_Carryall_cbr,mjb_carryallplus_cbr,"Carryall Backpack (Coyote/plus)");
  PACKPLUS(B_Carryall_eaf_F,mjb_carryallplus_eaf_F,"Carryall Backpack (Geometric/plus)");
  PACKPLUS(B_Carryall_ghex_F,mjb_carryallplus_ghex,"Carryall Backpack (Green Hex/plus)");
  PACKPLUS(B_Carryall_green_F,mjb_carryallplus_green,"Carryall Backpack (Green/plus)");
  PACKPLUS(B_Carryall_khk,mjb_carryallplus_khk,"Carryall Backpack (Khaki/plus)");
  PACKPLUS(B_Carryall_mcamo,mjb_carryallplus_mcamo,"Carryall Backpack (MTP/plus)");
  PACKPLUS(B_Carryall_ocamo,mjb_carryallplus_ocamo,"Carryall Backpack (Hex/plus)");
  PACKPLUS(B_Carryall_oli,mjb_carryallplus_oli,"Carryall Backpack (Olive/plus)");
  PACKPLUS(B_Carryall_oucamo,mjb_carryallplus_oucamo,"Carryall Backpack (Urban/plus)");
  PACKPLUS(B_Carryall_taiga_F,mjb_carryallplus_taiga_F,"Carryall Backpack (Taiga/plus)");
  PACKPLUS(B_Carryall_wdl_F,mjb_carryallplus_wdl,"Carryall Backpack (Woodland/plus)");

  PACKPLUS(rhs_tortila_black,mjb_carryallplus_black,"SPOSN Tortila Backpack (Black/plus)");
  PACKPLUS(rhs_tortila_emr,mjb_carryallplus_emr,"SPOSN Tortila Backpack (EMR-Summer/plus)");
  PACKPLUS(rhs_tortila_grey,mjb_carryallplus_grey,"SPOSN Tortila Backpack (Grey/plus)");
  PACKPLUS(rhs_tortila_khaki,mjb_carryallplus_khaki,"SPOSN Tortila Backpack (Khaki/plus)");
  PACKPLUS(rhs_tortila_olive,mjb_carryallplus_olive,"SPOSN Tortila Backpack (Olive/plus)");

  class Box_NATO_Ammo_F;
  class Box_Rats_Ammo : Box_NATO_Ammo_F {
    displayName = "Basic Ammo [RATS]";
    class ACE_Actions {
      class ACE_MainActions {
        condition = "true";
        displayName = "Interactions";
        distance = 2;
        selection = "";
        class ACE_OpenBox {
          condition = "alive _target && {!lockedInventory _target} && {getNumber (configOf _target >> 'disableInventory') == 0}";
          displayName = "Open";
          showDisabled = 0;
          statement = "_player action [""Gear"", _target]";
        };
        class mjb_ArsenalAmmo {
          condition = "alive _target && {!lockedInventory _target} && {getNumber (configOf _target >> 'disableInventory') == 0}";
          displayName = "RATS Ammo Arsenal";
          showDisabled = 0;
          statement = "[] call mjb_arsenal_fnc_arsenalAmmo";
        };
      };
    };
    class TransportItems {
    };
    // Limited AT
    class TransportMagazines {
      class _xx_rhs_rpg7_PG7VM_mag {
        count = 1;
        magazine = "rhs_rpg7_PG7VM_mag";
      };
      class _xx_rhs_rpg7_PG7VL_mag {
        count = 1;
        magazine = "rhs_rpg7_PG7VL_mag";
      };
      class _xx_rhs_rpg7_OG7V_mag {
        count = 2;
        magazine = "rhs_rpg7_OG7V_mag";
      };
      class _xx_MRAWS_HE_F {
        count = 1;
        magazine = "MRAWS_HE_F";
      };
      class _xx_MRAWS_HEAT55_F {
        count = 1;
        magazine = "MRAWS_HEAT55_F";
      };
      class _xx_MRAWS_HEAT_F {
        count = 1;
        magazine = "MRAWS_HEAT_F";
      };
      class _xx_Titan_AT {
        count = 1;
        magazine = "Titan_AT";
      };
      class _xx_DemoCharge_Remote_Mag {
        count = 2;
        magazine = "DemoCharge_Remote_Mag";
      };
    };
    // disposables
    class TransportWeapons {
      class _xx_rhs_weap_rpg75 {
        count = 1;
        weapon = "rhs_weap_rpg75";
      };
      class _xx_rhs_weap_M136 {
        count = 1;
        weapon = "rhs_weap_M136";
      };
      class _xx_CUP_launch_FIM92Stinger {
        count = 1;
        weapon = "CUP_launch_FIM92Stinger";
      };
    };
	/*private _itemWeaponLAT =
	[
		"CUP_launch_M136", // Better than RHS HEAT
		"CUP_launch_M72A6",
		"CUP_launch_RPG26",

		"rhs_weap_rpg75", // Not much better than m72s in the configs
		"rhs_weap_M136", // HEAT
		"rhs_weap_M136_hedp", // Not great for AT
		"rhs_weap_M136_hp", // High Penetration

		"rhs_acc_at4_handler",

		//Launchers in Backpack
		"CUP_launch_M136_Loaded",
		"CUP_launch_M72A6_Loaded",
		"CUP_M72A6_M",
		"CUP_launch_RPG26_Loaded"
	];

	private _itemWeaponManpad = {
		"CUP_launch_FIM92Stinger"
	};
	private _itemAmmoLAT =
	[
		//RPG Rockets (Uncomment desired rockets)

		 "rhs_rpg7_OG7V_mag",
		// "rhs_rpg7_PG7V_mag",
		 "rhs_rpg7_PG7VL_mag", // High pen
		 "rhs_rpg7_PG7VM_mag", //
		// "rhs_rpg7_PG7VR_mag", // Very High Pen Tandem
		// "rhs_rpg7_PG7VS_mag", // Between VM and VL, ~AT4 HEAT
		// "rhs_rpg7_TBG7V_mag",
		// "rhs_rpg7_type69_airburst_mag"

		"MRAWS_HE_F",
		"MRAWS_HEAT55_F"
	];

	private _itemAmmoMAT =
	[
		"MRAWS_HEAT_F",
		"MRAWS_HEAT55_F",
		"MRAWS_HE_F"
	];
	private _itemAmmoHAT =
	[
		"Titan_AT"
	];*/
  };

/*/ GM Compats compat
class Land_CanisterFuel_F;
  class gm_jerrycan_base : Land_CanisterFuel_F {
    scope = 1;
    side = 1;
  };
  class gm_gc_army_shelterlakII_repair_base {
    scope = 1;
    side = 1;
  };
  class gm_ge_army_shelteraceII_repair_base {
    scope = 1;
    side = 1;
  };/*/

  /*/ Launcher from vehicle, failed
  class RHS_MELB_base;
  
  class RHS_MELB_MH6M : RHS_MELB_base {
	class NewTurret;
    class CargoTurret : NewTurret{
        allowLauncherIn = 1;
        allowLauncherOut = 1;
      };
	class Turrets {
      class CargoTurret_03 : CargoTurret {
        allowLauncherIn = 1;
        allowLauncherOut = 1;
      };
    };
  };//*/

  /*/ MFD is a lot tho
  class Helicopter_Base_H;
  class Heli_Attack_01_dynamicLoadout_base_F;
  class B_Heli_Attack_01_dynamicLoadout_F : Heli_Attack_01_dynamicLoadout_base_F {
    class MFD;
  };

  class Heli_Transport_01_base_F : Helicopter_Base_H {
    //class MFD : MFD;
  };

  class Heli_Light_02_dynamicLoadout_base_F;
  class O_Heli_Light_02_dynamicLoadout_F : Heli_Light_02_dynamicLoadout_base_F {
    class MFD;
  };

  class Heli_Attack_02_dynamicLoadout_base_F;
  class O_Heli_Attack_02_dynamicLoadout_F : Heli_Attack_02_dynamicLoadout_base_F {
    class MFD;
  };

  class I_Heli_light_03_base_F;
  class I_Heli_light_03_F : I_Heli_light_03_base_F {
    class MFD {
		class Airplane_HUD {
			class Bones {
			};
			class Draw {
				class CollectiveGroup {
				};
				class HorizontalLine {
				};
				class MGun {
				};
				class Rockets {
				};
			};
		};
		class MFD_Pilot_10 {
			class Bones {
			};
			class Draw {
				class ReticleGroup {
				};
			};
		};
    };
  };//*/
};