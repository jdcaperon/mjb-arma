
class CfgAmmo
{
	class BulletCore;
	class BulletBase: BulletCore {};
	class B_556x45_Ball: BulletBase	{};
	class B_762x51_Ball: BulletBase	{};

	// MMG Tracer ammo
	class B_338_NM_Ball: BulletBase {};
	class mjb_338_NM_trc_gr: B_338_NM_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_green"; };
	class mjb_338_NM_trc_ylw: B_338_NM_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_yellow"; };
	
	class B_93x64_Ball: BulletBase {};
	class mjb_93x64_trc_red: B_93x64_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_red"; };
	class mjb_93x64_trc_ylw: B_93x64_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_yellow"; };

	class rhs_g_vog25;
	class mjb_g_vogmdp : rhs_g_vog25 {
		indirectHitRange = 4;
		submunitionAmmo = "rhs_ammo_40mmHEDP_penetrator";
	};



	// Rocket use flags
	// cup rpg18, smaw hedp n, smaw spotting
	
	
	
	
	// Ammo Balance, spreadsheet with changes: https://docs.google.com/spreadsheets/d/1hBv11wZy6fM9IIj6Qh0-j3qezPhqOBt0XZLNUT1HfvQ/edit#gid=0
	// RHS has very different stats for ammo, resulting in stronger or weaker than expected performance.
	// These configs change them to closer match ACE/Vanilla and balance ammos in general
	// airFriction: affects bullet drop and damage falloff, 0 is no drop/falloff, -0.001 is ~average
	// caliber: how well a bullet penetrates, higher is more penetrative
	// hit: base damage of a bullet
	// Initial bullet speed is set on magazines with a possible override on weapons, will be much more difficult to change
	/*
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
	*/
};
