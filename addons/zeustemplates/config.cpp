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
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_atolls_gdc {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Atolls GDC";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.atolls_gdc";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_intro {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Rahmadi";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.intro";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_Malden {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Malden 2035";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Malden";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_porto {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Porto";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.porto";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_pulau {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Pulau";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.pulau";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_sara {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Sahrani";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.sara";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_sara_dbe1 {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Sahrani United";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.sara_dbe1";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_Stratis {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Stratis";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Stratis";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_Tanoa {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Tanoa";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.Tanoa";
			overview = "";
			overviewText = "Zeus template for RATS.";
		};
		class mjb_rzt_utes {
			author = "NotherDuck, MajorDanvers";
			briefingName = "Zeus Template 2,0 Utes";
			directory = "z\mjb\addons\zeustemplates\missions\MJB_Zeus_Template_V2,0_510.utes";
			overview = "";
			overviewText = "Zeus template for RATS.";
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
				};				
			};
		};
	};
};