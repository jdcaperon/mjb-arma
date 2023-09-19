/**
    * Adds curated arsenal to player that disables itself under specified conditions.
    *
    * Faction: MJB ARMA default PMCs
    *
    * Usage - under initPlayerLocal.sqf
    * 0 = execVM 'loadouts\arsenal.sqf';
    *
    * New framework update by NotherDuck
    * Equipment and quality hat choices by MajorDanvers
    * Formatting by veerserif
    *
    * v0.5 - 2021-08-20:
        - Removed ACRE Radios
        - Removed EFT Uniforms with Beltstaff Pants (White LOD Issue)
        - Added weapons and attachments requested in framework doc.
        - Gave all roles access to tracers where possible.
        - Moved DMRs (M14, SR-25, SVDS) and Shortdot to seperate role (_itemWeaponSharpshooter).
        - Added LAT Equipment (_itemWeaponLAT).
    * v1.0 - 2021-08-21:
        - Fixed several typos with magazines and added some missing ones (150 rnd 7.62x54r Box)
        - Moved shotguns and smgs to seperate section (_itemWeaponCQB, still given to all classes with normal rifles)
        - Added section for high capacity rifle mags (_itemWeaponHighCapAmmo, given to SF)
    * v1.1 - 2021-08-26:
        - Added ACRE radios back to arsenal.
        - Removed CUP lasers.
        - Fixed some roles not having access to pistols.
        - Added NAPA drip hoodie.
    * v1.1a - 2021-08-31:
        - Removed heli coveralls from normal infantry roles.
        - Gave tank and air crews access to CQB weapons.
    * v1.2 - 2021-09-01:
        - Added carbine variants requested by VierLeger (VHS-K2, ACR-C, F2000 Tactical, Mk17 CQC, Mk18).
    * v1.2a - 2021-09-14:
        - Added the AK-104 and AK-74M.
        - Changed AK-105 variant to B-13 version (rail can be removed using CTRL+C by default to access dovetail sights)
        - Fixed LAT and HAT roles having access to binoculars.
    * v2.0 - 2021-10-08:
        - Replaced all RHS and T1 content with CUP versions
        - Added trivial cosmetics for specific roles (ex. AR, Leaders)
    * v2.1 - 2022-01-22:
        - AKA the RHS one
            - All AR-pattern rifles switched out for RHS variants
            - RHS AKs added to augment our CUP AKs(yay for folding stocks!)
            - RHS optics and accessories added
            - Some RHS cosmetics added
            - Added some vanilla fatigues to match our MWS fatigues
            - More backpack colors
            - M110 SASS and M14 EBR for sharpshooters
            - TAR-21 for vanilla troopers
    * v2.1a - 2022-01-30:
            - Left most CUP AR-pattern rifles for GL roles, some might prefer the holo dot gl sight
            - Prioritized model quality and variety when removing/replacing guns, CUP has nicer wood furniture usually.
            - Added RHS disposables and RPG-7 with similar AT strength rockets
            - ACE Vector and RHS Binocs
            - Couple RHSGREF camos
            - Winter variable to enable winter camo gear, these are currently weaker than our normal gear
            - Added RHS rifles to Sharpshooter and Sniper
            - Replaced CUP MP7 and added PP2000 and M590 in CQB weapons
            - Added M145 optic and a couple RHS AR options to ARs
            - Gave SF some vests from the pre-nuke arsenal, RHS AS Val, and a special pistol
            - Gave helo and tank crews pre-nuke vests (sorry air ;-;)
            - Blyat
            - Beltstaff yeeted (un-yeeted non-bugged shirts)
            - Added 20 round 9x39 mag and corrected 9x39 ammo box class name to ball
        - 2022-02-02:
            - Gave up trying to limit size and added a ton more weapons
            - Removed a few redundancies
        -2022-02-04:
            - Scav uniforms
        -2022-02-11:
            - MMG team (mjbLOVE to Banzerschreck), not shaking down AR yet
            - Moved non-base/med backpacks into _itemPackMedium and _itemPackHeavy

    * Arguments:
      * 0: Apply to JIPs, players coming in after will use these parameters to generate
              a personal arsenal, default: false <BOOLEAN> !!Must be Global Exec'd to work!!
      * 1: Role for the target(s) to use, nil or "" to use TMF, or unit type.
              default: TMF role, (typeOf _unit) if no TMF role set in editor <STRING>
      * 2: Remove existing Personal Arsenal, default: true <BOOLEAN>
      * 3: Additional gear to include <ARRAY> of <STRING> class names, default: []
      * 4: Winter camo available, default: true <BOOLEAN>

      !! JIP param true Must be Global Exec'd to work !!

    ex.: [true, nil, true, ["ACRE_BF888S","tier1_exps3_0_g33_black_up"]] call mjb_arsenal_fnc_arsenalAmmo;
*/

//if !(didJIP) then {
    if (isNil "mjb_arsenalAmmo") then {
        mjb_arsenalAmmo = "building" createVehicleLocal [0,0,0];
    };
//};

#include "_arsenalMacros.hpp"

//Variables
private _aceMedLoaded = isClass(configFile >> "CfgPatches" >> "ace_medical_engine"); //Store whether ace med is present

//Define Arsenal Items
private _itemEquipment =
[
    "ACRE_PRC343",
    "ACE_IR_Strobe_Item"
];

private _itemNVG =
[
    "NVGoggles",
    "NVGoggles_OPFOR",
    "CUP_NVG_GPNVG_black",
    "CUP_NVG_GPNVG_winter",
    "CUP_NVG_GPNVG_tan"
];
_itemEquipment append _itemNVG;

private _itemSpecial =
[
    //============================================================
    //Radios
    //============================================================
    "ACRE_PRC148",
    "ACRE_PRC152",
    "ACRE_PRC117F"
];

private _itemWeaponPistol =
[

    //Magazines
    "CUP_13Rnd_9x19_Browning_HP",
    "CUP_16Rnd_9x19_cz75",
    "CUP_17Rnd_9x19_M17_Black",
    "CUP_8Rnd_9x18_Makarov_M",
    "CUP_12Rnd_45ACP_mk23",
    "CUP_15Rnd_9x19_M9",
    "CUP_7Rnd_45ACP_1911",
    "CUP_17Rnd_9x19_glock17",
    "CUP_8Rnd_762x25_TT",

    "rhs_mag_9x19_17",

    "Tier1_15Rnd_9x19_JHP",
    "Tier1_17Rnd_9x19_P320_JHP",

    //Loose ammo
    "greenmag_ammo_9x19_basic_30Rnd",
    "greenmag_ammo_9x21_basic_30Rnd",
    "greenmag_ammo_45ACP_basic_30Rnd",
    "greenmag_ammo_9x18_basic_30Rnd",
    "greenmag_ammo_762x25_ball_30Rnd"
];

private _itemLeaderEquipment =
[
    "CUP_6Rnd_45ACP_M",
    "CUP_7Rnd_50AE_Deagle",
    "6Rnd_45ACP_Cylinder",

    "greenmag_ammo_50AE_ball_30Rnd" // deagle rounds
];

private _itemWeaponAmmo =
[
    //============================================================
    //5.56x45mm
    //============================================================
    //Magazines
    "CUP_30Rnd_556x45_Emag",
    "CUP_30Rnd_556x45_PMAG_QP",
    "CUP_30Rnd_556x45_XM8",
    "CUP_25Rnd_556x45_Famas",
    "CUP_30Rnd_556x45_AK",
    "CUP_20Rnd_556x45_Stanag",

    //Loose ammo
    "greenmag_ammo_556x45_basic_60Rnd",

    //============================================================
    //5.45x39mm
    //============================================================
    //Magazines
    "CUP_30Rnd_545x39_Fort224_M",
    "CUP_30Rnd_545x39_AK_M",
    "CUP_30Rnd_545x39_AK74M_M",

    //Loose ammo
    "greenmag_ammo_545x39_basic_60Rnd",

    //============================================================
    //7.62x39mm
    //============================================================
    //Magazines
    "CUP_30Rnd_762x39_AK47_bakelite_M",
    "CUP_30Rnd_762x39_AK47_M",
    "CUP_30Rnd_Sa58_M",

    "rhs_30Rnd_762x39mm_Savz58",

    //Loose ammo
    "greenmag_ammo_762x39_basic_60Rnd",

    //============================================================
    //7.62x51mm
    //============================================================
    //Magazines
    "CUP_20Rnd_762x51_FNFAL_M",
    "CUP_20Rnd_762x51_B_SCAR",
    "CUP_20Rnd_762x51_HK417",

    //Loose ammo
    "greenmag_ammo_762x51_basic_60Rnd",

    //============================================================
    //7.62x54mm
    //============================================================
    //Magazines
    //Loose ammo
    "greenmag_ammo_762x54_basic_60Rnd",

    //============================================================
    //Grenades
    //============================================================
    //HE and frags
    "HandGrenade",

    //Smokes
    "SmokeShell",
    "SmokeShellGreen",
    "SmokeShellRed",
    "SmokeShellPurple",
    "SmokeShellBlue",

    //Make eyeballs hurt
    "ACE_M84",
    "ACE_Chemlight_HiGreen",

    // Other Loose
    "greenmag_ammo_765x17_ball_60Rnd",
    "greenmag_ammo_650x39_basic_60Rnd",
    "greenmag_ammo_580x42_basic_60Rnd",
    "greenmag_ammo_570x28_basic_60Rnd",
    "greenmag_ammo_50BW_basic_60Rnd",
    "greenmag_ammo_408_basic_60Rnd",
    "greenmag_ammo_303_ball_60Rnd",
    "greenmag_ammo_127x54_basic_60Rnd"
];

private _itemWeaponTracerAmmo =
[
    //============================================================
    //5.56x45mm
    //============================================================
    "CUP_30Rnd_556x45_Emag_Tracer_Yellow",
    "CUP_30Rnd_556x45_PMAG_QP_Tracer_Yellow",
    "CUP_30Rnd_TE1_Yellow_Tracer_556x45_XM8",
    "CUP_25Rnd_556x45_Famas_Tracer_Yellow",
    "CUP_30Rnd_TE1_Yellow_Tracer_556x45_AK",
    "CUP_30Rnd_556x45_TE1_Tracer_Green_AK19_Tan_M",
    "CUP_20Rnd_556x45_Stanag_Tracer_Yellow",

    //============================================================
    //5.45x39mm
    //============================================================
    "CUP_30Rnd_TE1_Yellow_Tracer_545x39_Fort224_M",
    "CUP_30Rnd_TE1_Yellow_Tracer_545x39_AK74M_M",

    //============================================================
    //7.62x39mm
    //============================================================
    "CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_bakelite_M",
    "CUP_30Rnd_Sa58_M_TracerY",
    "CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_M",

    "rhs_30Rnd_762x39mm_Savz58_tracer",

    //============================================================
    //7.62x51mm
    //============================================================
    "CUP_20Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M",
    "CUP_20Rnd_TE1_Yellow_Tracer_762x51_SCAR",
    "CUP_20Rnd_TE1_Yellow_Tracer_762x51_HK417"

    //============================================================
    //7.62x54mm
    //============================================================

    //============================================================
    //Misc Calibers (SMGs, Shotguns, Etc.)
    //============================================================
];

private _itemWeaponHighCapAmmo =
[
    //============================================================
    //5.56x45mm
    //============================================================
    "CUP_60Rnd_556x45_SureFire",
    "CUP_60Rnd_556x45_SureFire_Tracer_Yellow",
    "CUP_50Rnd_556x45_Green_Tracer_Galil_Mag",

    //============================================================
    //5.45x39mm
    //============================================================
    "CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M",
    "CUP_60Rnd_545x39_AK74M_M",
    "CUP_60Rnd_TE1_Yellow_Tracer_545x39_AK74M_M",

    //============================================================
    //7.62x39mm
    //============================================================
    "CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",
    "CUP_45Rnd_Sa58_M",
    "CUP_45Rnd_Sa58_M_TracerY",
    "CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",

    //============================================================
    //7.62x51mm
    //============================================================
    "CUP_30Rnd_762x51_FNFAL_M",
    "CUP_30Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M"

    //============================================================
    //7.62x54mm
    //============================================================
];

private _itemWeaponCQB =
[
    //============================================================
    //Magazines
    //============================================================
    //SMGs
    "CUP_40Rnd_46x30_MP7",
    "CUP_20Rnd_B_765x17_Ball_M",
    "CUP_30Rnd_9x39_SP5_VIKHR_M",
    "CUP_20Rnd_9x39_SP5_VSS_M",
    "CUP_30Rnd_45ACP_MAC10_M",
    "CUP_30Rnd_9x19_MP5",
    "CUP_30Rnd_9x19_Vityaz",
    "CUP_64Rnd_9x19_Bizon_M",
    "CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M",

    "rhs_mag_9x19mm_7n21_20",
    "rhs_mag_9x19mm_7n21_44",

    //Shotguns
    "CUP_5Rnd_B_Saiga12_Buck_00",
    "CUP_5Rnd_B_Saiga12_Slug",
    "CUP_12Rnd_B_Saiga12_Buck_00",
    "CUP_12Rnd_B_Saiga12_Slug",
    "CUP_8Rnd_12Gauge_Pellets_No00_Buck",
    "CUP_8Rnd_12Gauge_Slug",

    "rhsusf_8Rnd_00Buck",
    "rhsusf_5Rnd_00Buck",
    "rhsusf_5Rnd_Slug",

    //============================================================
    //Loose ammo
    //============================================================
    "greenmag_ammo_46x30_basic_60Rnd",
    "greenmag_ammo_765x17_basic_60Rnd",
    "greenmag_ammo_9x39_ball_60Rnd",
    "greenmag_ammo_45ACP_basic_60Rnd",
    "greenmag_ammo_9x19_basic_60Rnd",
	"greenmag_ammo_12G_basic_12Rnd",
	"greenmag_ammo_12G_basic_24Rnd"
];

private _itemWeaponSFAR =
[
    "CUP_100Rnd_556x45_BetaCMag_ar15",
    "CUP_100Rnd_TE1__Yellow_Tracer_556x45_BetaCMag_ar15"
];

private _itemWeaponARAmmo =
[
    //============================================================
    //5.56x45mm
    //============================================================
    //Boxes
    "CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249",
    "CUP_100Rnd_TE4_Yellow_Tracer_556x45_M249",
    //Loose belts
    GREENMAG_BELT(556x45),

    //============================================================
    //7.62x51mm
    //============================================================
    //Boxes
    "CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
    "CUP_120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
    //Loose belts
    GREENMAG_BELT(762x51),

    //============================================================
    //7.62x54mmR
    //============================================================
    //Boxes
    "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M",

    //Loose belts
    GREENMAG_BELT(762x54)
];

private _itemWeaponSharpshooter =
[

    //============================================================
    //Magazines
    //============================================================
    //7.62x51mm
    "ace_20rnd_762x51_m118lr_mag",
    "ace_20rnd_762x51_mag_tracer",

    "rhsusf_20Rnd_762x51_SR25_m993_Mag",

    //7.62x54mmR
    "ace_10rnd_762x54_tracer_mag",

    "rhs_10Rnd_762x54mmR_7N14"
];

private _itemSniper =
[
    "ace_5rnd_127x99_api_mag",

    "CUP_10Rnd_127x99_M107",
    "CUP_5Rnd_127x99_as50_M",
    "CUP_10Rnd_762x51_CZ750",
    "CUP_5Rnd_86x70_L115A1",
    "CUP_5Rnd_127x108_KSVK_M",
    "CUP_5Rnd_762x51_M24",

    "rhsusf_5Rnd_762x51_m118_special_Mag",
    "rhsusf_5Rnd_762x51_m993_Mag",
    "rhsusf_10Rnd_762x51_m118_special_Mag",
    "rhsusf_10Rnd_762x51_m993_Mag",
    "rhs_5Rnd_338lapua_t5000",

    "CUP_40Rnd_46x30_MP7"
];
private _itemSniperAmmo = [
    "greenmag_ammo_127x99_basic_30Rnd",
    "greenmag_ammo_127x99_basic_60Rnd",
    "greenmag_ammo_127x108_basic_30Rnd",
    "greenmag_ammo_127x108_basic_60Rnd",
    "greenmag_ammo_338_basic_30Rnd",
    "greenmag_ammo_338_basic_60Rnd",
    "greenmag_ammo_46x30_basic_60Rnd",
    "greenmag_ammo_93x64_basic_60Rnd"
];

private _itemWeaponGL =
[
    // Fancy mags
    "CUP_30Rnd_TE1_Green_Tracer_545x39_AK12_Tan_M",
    "CUP_30Rnd_TE1_Green_Tracer_762x39_AK15_Tan_M",
    "CUP_30Rnd_556x45_TE1_Tracer_Green_AK19_Tan_M",
    "CUP_30Rnd_680x43_Stanag_Tracer_Yellow",

    "greenmag_ammo_680x43_tracer_60Rnd",

    //============================================================
    //Grenade Rounds
    //============================================================
    //NATO
    "1Rnd_HE_Grenade_shell",
    "ACE_40mm_Flare_white",
    "ACE_40mm_Flare_ir",
    "1Rnd_Smoke_Grenade_shell",
    "1Rnd_SmokeRed_Grenade_shell",
    "1Rnd_SmokeBlue_Grenade_shell",
    "1Rnd_SmokeGreen_Grenade_shell",

    //Rusfor
    "CUP_1Rnd_HE_GP25_M",
    "CUP_IlumFlareWhite_GP25_M",
    "CUP_1Rnd_SMOKE_GP25_M",
    "CUP_1Rnd_SmokeRed_GP25_M",
    "CUP_1Rnd_SmokeGreen_GP25_M",
    "rhs_VOG25",
    "rhs_VG40TB",

	"mjb_VOGMDP"
];

private _itemWeaponSFSL =
[
    "rhs_VG40MD"
];

private _itemWeaponLAT =
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
];

private _itemWeaponMMGAmmo =
[
    "150Rnd_762x51_Box_Tracer",
    "130Rnd_338_Mag",
    "mjb_130Rnd_338_Mag_trc_ylw",
    "150Rnd_93x64_Mag",
    "mjb_150Rnd_93x64_Mag_trc_ylw",
    GREENMAG_BELT(338),
    GREENMAG_BELT(93x64),
    GREENMAG_BELT(650x39)
];

private _itemSF =
[
    "CUP_20Rnd_B_AA12_Buck_00",
    "CUP_20Rnd_B_AA12_Slug",
    "CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
    "rhs_20rnd_9x39mm_SP6",
    "rhs_18rnd_9x21mm_7BT3",
    "rhs_18rnd_9x21mm_7N29",
    "Tier1_30Rnd_762x35_300BLK_RNBT_EMag",
    "Tier1_30Rnd_762x35_300BLK_SMK_EMag",
    "Tier1_30Rnd_762x35_300BLK_EMag"
];

private _itemEngineer =
[
    //Tools
    "ACRE_148",
    "DemoCharge_Remote_Mag",
    "ACE_M14",
    "ATMine_Range_Mag",
    "ACE_FlareTripMine_Mag",
    "APERSTripMine_Wire_Mag",
    "SLAMDirectionalMine_Wire_Mag",
    "ClaymoreDirectionalMine_Remote_Mag",
    "TrainingMine_Mag",
    "ACE_UAVBattery",
    "ACE_SpraypaintBlack",
    "ACE_Rope36",
    "ACE_Rope15",
    "ACE_Chemlight_HiBlue",
    "ACE_Chemlight_HiYellow",
    "ACE_Chemlight_UltraHiOrange",
    "ACE_TacticalLadder_Pack",

    "rhs_charge_sb3kg_mag",
    "rhs_charge_tnt_x2_mag",
    "rhs_mag_an_m14_th3"
];

private _itemAirCrew =
[
    "ACE_IR_Strobe_Item",
    "ACRE_PRC148",
    "ACE_Chemlight_UltraHiOrange",
    "SmokeShellOrange"
];

private _itemMedical = [""];
private _itemMedicalAdv = [""];

if (_aceMedLoaded) then { //Check for ace med
    _itemMedical =
    [
        //Bandages
        "ACE_fieldDressing",
        "ACE_elasticBandage",
        "ACE_packingBandage",
        "ACE_quikclot",
        //Specialized Equipments
        "ACE_splint",
        "ACE_tourniquet",
        //Rifleman Medications
        "ACE_epinephrine",
        "ACE_morphine"
    ];
    {_x append _itemMedical} forEach [_itemEquipment, _itemTankCrew, _itemHeloCrew, _itemAirCrew];
    // Append ACE Med Items
    _itemMedicalAdv =
    [
        //Fluids
        "ACE_bloodIV",
        "ACE_bloodIV_250",
        "ACE_bloodIV_500",
        "ACE_plasmaIV",
        "ACE_plasmaIV_250",
        "ACE_plasmaIV_500",
        "ACE_salineIV",
        "ACE_salineIV_250",
        "ACE_salineIV_500",
        //Medications
        "ACE_adenosine",
        //Specialized Equipments
        "ACE_personalAidKit",
        "ACE_surgicalKit"
    ];
  _itemMedic append _itemMedicalAdv;
} else { // Add base med items
    {_x pushBack "FirstAidKit";} forEach [_itemEquipment, _itemTankCrew, _itemHeloCrew, _itemAirCrew];
    _itemMedic append ["Medikit", "diw_armor_plates_main_autoInjector"];
};

/*/Add Existing Player Items
waitUntil {!isNull player}; // should prevent FAKs/Medikits from adding when ACE enabled.
if (didJIP && isNil "mjb_arsenal_JIPinit") then {
  sleep 1; // waitUntil {(speed player) > 0.5};
    if (_removeOld && {!(isNil "arsenal")}) then {
        [typeOf player, 1,["ACE_SelfActions","personal_arsenal"]] call ace_interact_menu_fnc_removeActionFromClass;
        deleteVehicle arsenal;
    } else {
        if (!(isNil "arsenal") && {isNil "missionArsenal"}) then {
            missionArsenal = arsenal;
            private _action =
            [
                "mission_arsenal","Mission Arsenal","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",
                {
                    lockIdentity player;
                    [missionArsenal, _player] call ace_arsenal_fnc_openBox
                },
                {
                    (player distance2d (player getVariable ["startpos",[0,0,0]])) < 200
                },
                {},
                [],
                [0,0,0],
                3
            ] call ace_interact_menu_fnc_createAction;
            ["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
            [typeOf player, 1,["ACE_SelfActions","personal_arsenal"]] call ace_interact_menu_fnc_removeActionFromClass;
        };
    };
    arsenal = "building" createVehicleLocal [0,0,0];
    mjb_arsenal_JIPinit = true;
};
//
private _exWeap = weaponsItems player; // Weapons, attachments, loaded mags/ub
for "_y" from 0 to (count _exWeap - 1) do {
    {
        if (count _x == 2) then { _itemEquipment pushBackUnique (_x # 0);}
        else { _itemEquipment pushBackUnique _x;};
    } forEach (_exWeap # _y);
};

{
    _itemEquipment pushBackUnique _x;
} forEach (assignedItems player + itemsWithMagazines player + [uniform player, vest player, backpack player, headgear player]); // All other equipment

private _tarkovuniforms = ["Tarkov_Uniforms_49"]; // most cursed is not cursed
private _whiteTexBugged = [55,56,58,59,61,62,63,64,65,68,71,72]; // bugged shirts
for [{_i = 2}, {_i < 623}, {_i = _i + 24}] do // skips Beltstaff pants
{ for "_j" from (_i) to (_i + 22) do
  { if ((_whiteTexBugged findIf {_j == _x}) == -1) then {
    _tarkovuniforms pushback ("Tarkov_Uniforms_" + str _j) }; };
};
for "_i" from (1) to (49) do { _tarkovuniforms pushback ("Tarkov_Uniforms_Scavs_" + str _i) };

_itemEquipment append _additions;
private _tarkovuniforms = [];
private _itemPackMedium = [];
private _itemPackHeavy = [];
private _itemFacewear = [];
private _itemMod = [];
private _itemReflexSight = [];

private _unitRole = (player getVariable ["tmf_assignGear_role",typeOf player]);
if (_role isNotEqualTo "") then {systemChat ("Using set role: " + _role); _unitRole = _role;
} else { systemChat ("No role set, defaulting to: " + _unitRole); };
private _leaderRole = ["tl","sl","B_officer_F","B_Soldier_SL_F"];
//Match unitrole name with the classnames in loadout.
switch (true) do
{
    case (_unitRole == "ar") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponAR + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "aar") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemPackMedium + _tarkovuniforms + ["Binocular"])] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole in _leaderRole) :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemSpecial + _itemMod + _itemReflexSight + _itemWeaponGL + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "r") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemWeaponGL)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "cls") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemMedic)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "mat") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemWeaponMAT + _itemMod + _itemReflexSight +  _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "amat") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "lat") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "sniper") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemWeaponSniper + _itemSniper + _itemSniperAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "spotter") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponRifle + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemSniper + _itemSniperAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "sfsl") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponGL + _itemWeaponSFSL + _itemWeaponCQB + _itemSpecial + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemAmmoMAT + _itemWeaponARAmmo + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemPackMedium + _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "sfmed") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "sfmat") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemWeaponMAT + _itemAmmoMAT + _itemPackMedium + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "sfar") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponAR + _itemWeaponARAmmo + _itemWeaponSFAR + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponMMG + _itemWeaponMMGAmmo + _itemPackMedium + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "sfdmr") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter +  _itemWeaponSniper + _itemSniper + _itemAmmoMAT + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "ceng") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemEngineer + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        if (isNil "mjb_engiButtonId") then {mjb_engiButtonId = -1;};
        mjb_engiButtonId = [(_itemEngineer), "Engineer","\A3\ui_f\data\igui\cfg\actions\repair_ca.paa", mjb_engiButtonId] call ace_arsenal_fnc_addRightPanelButton;
    };
    case (_unitRole == "crew") :
    {
        [mjb_arsenalAmmo, (_ItemTankCrew + _itemFacewear + _itemWeaponCQB + _itemWeaponPistol + _itemReflexSight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "helocrew") :
    {
        [mjb_arsenalAmmo, (_ItemHeloCrew + _itemFacewear + _itemWeaponCQB + _itemWeaponPistol + _itemReflexSight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "aircrew") :
    {
        [mjb_arsenalAmmo, (_ItemAirCrew + _itemFacewear + _itemWeaponPistol + _itemLeaderEquipment)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "hat") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponHAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "ahat") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "mmg") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponAR + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMG + _itemWeaponMMGAmmo + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "ammg") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine+ _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMGAmmo  + _itemPackHeavy + _tarkovuniforms + ["Binocular"])] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "full") :
    {
        [mjb_arsenalAmmo, true] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_Soldier_AR_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponAR + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_Soldier_AAR_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemPackMedium + _tarkovuniforms + ["Binocular"])] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_Soldier_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemWeaponGL)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_medic_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemMedic)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_Soldier_LAT_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemWeaponMAT + _itemMod + _itemReflexSight +  _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_T_Soldier_AAT_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoMAT + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_Soldier_LAT2_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_Sharpshooter_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemWeaponSniper + _itemSniper + _itemSniperAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_Spotter_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponRifle + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemSniper + _itemSniperAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_recon_TL_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponGL + _itemWeaponSFSL + _itemWeaponCQB + _itemSpecial + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemAmmoMAT + _itemWeaponARAmmo + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemPackMedium + _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_recon_medic_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_recon_LAT_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemWeaponMAT + _itemAmmoMAT + _itemPackMedium + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_Patrol_Soldier_MG_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponAR + _itemWeaponARAmmo + _itemWeaponSFAR + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemAmmoMAT + _itemMedic + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponMMG + _itemWeaponMMGAmmo + _itemPackMedium + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_engineer_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemEngineer + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        if (isNil "mjb_engiButtonId") then {mjb_engiButtonId = -1;};
        mjb_engiButtonId = [(_itemEngineer), "Engineer","\A3\ui_f\data\igui\cfg\actions\repair_ca.paa", mjb_engiButtonId] call ace_arsenal_fnc_addRightPanelButton;
    };
    case (_unitRole == "B_crew_F") :
    {
        [mjb_arsenalAmmo, (_ItemTankCrew + _itemFacewear + _itemWeaponCQB + _itemWeaponPistol + _itemReflexSight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_helipilot_F") :
    {
        [mjb_arsenalAmmo, (_ItemHeloCrew + _itemFacewear + _itemWeaponCQB + _itemWeaponPistol + _itemReflexSight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_Pilot_F") :
    {
        [mjb_arsenalAmmo, (_ItemAirCrew + _itemFacewear + _itemWeaponPistol + _itemLeaderEquipment + _ItemHeloCrew + _itemFacewear + _itemWeaponCQB + _itemWeaponPistol + _itemReflexSight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole == "B_Soldier_AT_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemWeaponHAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_Soldier_AAT_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemAmmoHAT + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_HeavyGunner_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponAR + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMG + _itemWeaponMMGAmmo + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole == "B_Soldier_A_F") :
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine+ _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMGAmmo  + _itemPackHeavy + _tarkovuniforms + ["Binocular"])] call ace_arsenal_fnc_initBox;
    };
    default
    {
        [mjb_arsenalAmmo, (_itemEquipment + _itemWeaponCQB + _itemSpecial + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo)] call ace_arsenal_fnc_initBox;
    };
};*/
[mjb_arsenalAmmo, (_itemEquipment + _itemWeaponCQB + _itemSpecial + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponMMGAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemLeaderEquipment + _itemSF + _itemWeaponSharpshooter + _itemWeaponGL + _itemSniper + _itemSniperAmmo /*+ _itemWeaponSFAR*/)] call ace_arsenal_fnc_initBox;
    

if (isClass (configFile >> "CfgPatches" >> "greenmag_main")) then {
  private _greenmagArray = "getText (_x >> 'author') isEqualTo '[W] Miller' && {getText (_x >> 'displayName') isNotEqualTo 'Speedloader'}" configClasses (configFile >> "CfgWeapons") apply {configName _x};
  if (isNil "mjb_greenmagButtonId") then {mjb_greenmagButtonId = -1;};
  mjb_greenmagButtonId = [_greenmagArray, "Greenmag","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa", mjb_greenmagButtonId] call ace_arsenal_fnc_addRightPanelButton;
};

if (isNil "mjb_medicalButtonId") then {mjb_medicalButtonId = -1;};
mjb_medicalButtonId = [(["diw_armor_plates_main_plate","diw_armor_plates_main_autoInjector","FirstAidKit","Medikit"] + _itemMedical + _itemMedicalAdv), "Medical/Plates","\A3\ui_f\data\igui\cfg\cursors\unitHealer_ca.paa", mjb_medicalButtonId] call ace_arsenal_fnc_addRightPanelButton;

[mjb_arsenalAmmo, player] call ace_arsenal_fnc_openBox;