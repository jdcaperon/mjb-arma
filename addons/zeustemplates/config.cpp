class CfgPatches {
  class mjb_zeustemplate {
	ammo[] = {};
	magazines[] = {};
    units[] = {};
    weapons[] = {};
    requiredVersion = 0.1;
    author = "Alien314";
    name = "RATS Zeus Templates";
    requiredAddons[]=
		{
	   		//"ace_interact_menu"
		};
	};
};

class CfgMissions {

	class MPMissions {
		class mjb_rzt_Altis {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Altis";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Altis";
			overview = "z\mjb\addons\zeustemplates\overview.paa";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_atolls_gdc : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Atolls GDC";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.atolls_gdc";
		};
		class mjb_rzt_intro : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Rahmadi";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.intro";
		};
		class mjb_rzt_Malden : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Malden 2035";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Malden";
		};
		class mjb_rzt_porto : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Porto";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.porto";
		};
		class mjb_rzt_pulau : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Pulau";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.pulau";
		};
		class mjb_rzt_sara : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Sahrani";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.sara";
		};
		class mjb_rzt_saralite : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Southern Sahrani";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.saralite";
		};
		class mjb_rzt_sara_dbe1 : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Sahrani United";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.sara_dbe1";
		};
		class mjb_rzt_Stratis : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Stratis";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Stratis";
		};
		class mjb_rzt_Tanoa : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Tanoa";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Tanoa";
		};
		class mjb_rzt_utes : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Utes";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.utes";
		};
		class mjb_rzt_vr : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Virtual Reality";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.VR";
		};

		class mjb_rzt_Bootcamp_ACR : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Bukovina";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Bootcamp_ACR";
		};
		class mjb_rzt_chernarus : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Chernarus (Autumn)";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.chernarus";
		};
		class mjb_rzt_chernarus_summer : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Chernarus (Summer)";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.chernarus_summer";
		};
		class mjb_rzt_chernarus_winter : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Chernarus (Winter)";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.chernarus_winter";
		};
		class mjb_rzt_cup_chernarus_A3 : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Chernarus 2020";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.cup_chernarus_A3";
		};
		class mjb_rzt_Desert_E : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Desert";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Desert_E";
		};
		class mjb_rzt_Enoch : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Livonia";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Enoch";
		};
		class mjb_rzt_hellanmaa : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Hellanmaa";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.hellanmaa";
		};
		class mjb_rzt_hellanmaaw : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Hellanmaa winter";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.hellanmaaw";
		};
		class mjb_rzt_Maksniemi : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Maksniemi";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Maksniemi";
		};
		class mjb_rzt_Mountains_ACR : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Takistan Mountains";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Mountains_ACR";
		};
		class mjb_rzt_oski_corran : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Scottish Highlands";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.oski_corran";
		};
		class mjb_rzt_ProvingGrounds_PMC : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Proving Grounds";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.ProvingGrounds_PMC";
		};
		class mjb_rzt_rhspkl : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Prei Khmaoch Luong";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.rhspkl";
		};
		class mjb_rzt_ruha : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Ruha";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.ruha";
		};
		class mjb_rzt_Shapur_BAF : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Shapur";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Shapur_BAF";
		};
		class mjb_rzt_takistan : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Takistan";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.takistan";
		};
		class mjb_rzt_tem_anizay : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Anizay";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.tem_anizay";
		};
		class mjb_rzt_tem_kujari : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Kujari";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.tem_kujari";
		};
		class mjb_rzt_tem_summa : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Summa";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.tem_summa";
		};
		class mjb_rzt_tem_summawcup : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Summa winter";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.tem_summawcup";
		};
		class mjb_rzt_tem_vinjesvingenc : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Vinjesvingen";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.tem_vinjesvingenc";
		};
		class mjb_rzt_WL_Rosche : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Rosche, Germany";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.WL_Rosche";
		};
		class mjb_rzt_Woodland_ACR : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Bystrica";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Woodland_ACR";
		};
		class mjb_rzt_zargabad : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Zargabad";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.zargabad";
		};
		class mjb_rzt_tem_cham : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Cham";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.tem_cham";
		};
		class mjb_rzt_tem_chamw : mjb_rzt_Altis {
			briefingName = "Zeus Template 2,0 Cham Winter";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.tem_chamw";
		};

        
		class mjb_rzt_stratisFR : mjb_rzt_Altis {
			briefingName = "Stratis Firing Range v2,0";
			directory = "z\mjb\addons\zeustemplates\missions\Stratis_Firing_Range_V2,0_130.Stratis";
			overviewText = "Firing Range for RATS pre-session and testing.";
		};
	};

	class Campaigns {

		class ZeusTemplates {

			class NoEndings
			{
				// Arma 3
				endDefault = ;
			};

			class MissionDefault : NoEndings
			{
				lives		= -1;	// this sets your "lives" to none - old OFP setting where you would lose a "life" every time you retried the mission, never used
				noAward		=  1;	// TBD
				cutscene	= ;		// mandatory definition
			};

			directory = "z\mjb\addons\zeustemplates";
			weaponPool = 1;

			class Campaign
			{
				briefingName	= "Zeus Templates";
				author			= "NotherDuck, MajorDanvers, Alien314";
				overviewText	= "Missions for Zeuses to use to create missions.";
				overviewPicture	= "z\mjb\addons\zeustemplates\overview.paa";

				firstBattle	= Chapter1;
				disableMP	= 0;

				class Chapter1 : NoEndings
				{
					firstMission = Chapter1_Mission1;
					name = "Zeus Templates";
					cutscene = ;

					class Chapter1_Mission1 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.Altis;
					};

					class Chapter1_Mission2 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.atolls_gdc;
					};

					class Chapter1_Mission12 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.intro;
					};

					class Chapter1_Mission14 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.Malden;
					};

					class Chapter1_Mission17 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.porto;
					};

					class Chapter1_Mission19 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.pulau;
					};

					class Chapter1_Mission22 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.sara;
					};

					class Chapter1_Mission23 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.sara_dbe1;
					};

					class Chapter1_Mission25 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.Stratis;
					};

					class Chapter1_Mission27 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.Tanoa;
					};

					class Chapter1_Mission32 : MissionDefault
					{
						template = MJB_Zeus_Template_V2,0_510.utes;
					};

					class Chapter1_Mission33 : MissionDefault
					{
						template = Stratis_Firing_Range_V2,0_130.Stratis;
					};
				};				
			};
		};
	};
};