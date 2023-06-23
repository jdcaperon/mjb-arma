private _persist = (missionNamespace getVariable ["mjb_persistenceActive",false]);
if (_persist) then { missionNamespace setVariable ["tmf_common_ending",true,true]; };

_logic = _this select 0;
_units = _this select 1;
_activated = _this select 2;

if (_activated) then {
if (_logic call bis_fnc_isCuratorEditable) then {
waituntil {!isnil {_logic getvariable "updated"} || isnull _logic};
};
if (isnull _logic) exitwith {};

_typeCustom = _logic getvariable ["TypeCustom",""];
_win = _logic getvariable ["Win",true];
if ({isclass (_x >> "CfgDebriefing" >> _typeCustom)} count [configfile,campaignconfigfile,missionconfigfile] > 0) exitwith {
[[_typeCustom,_win,true,false],"bis_fnc_endMission"] call bis_fnc_mp;
};

_debriefing = missionnamespace getvariable [typeof _logic + "RscAttributeEndMission_debriefing",""];
RscDisplayDebriefing_params = _debriefing;
publicvariable "RscDisplayDebriefing_params";

_type = _logic getvariable ["Type",""];

[[_type,_win,true,false],"bis_fnc_endMission"] call bis_fnc_mp;

RscDisplayDebriefing_params = _debriefing;
publicvariable "RscDisplayDebriefing_params";

if (count objectcurators _logic > 0) then {deletevehicle _logic};
};

//curatorInfoType = "RscDisplayAttributesModuleEndMission";
/*
{
	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'BIS_fnc_moduleEndMission'} else {_fnc_scriptName};
	private _fnc_scriptName = 'BIS_fnc_moduleEndMission';
	scriptName _fnc_scriptName;

#line 1 "a3\modules_f_curator\intel\functions\fn_moduleEndMission.sqf [BIS_fnc_moduleEndMission]"
#line 1 "a3\modules_f_curator\intel\functions\fn_moduleEndMission.sqf"
_logic = _this select 0;
_units = _this select 1;
_activated = _this select 2;

if (_activated) then {
if (_logic call bis_fnc_isCuratorEditable) then {
waituntil {!isnil {_logic getvariable "updated"} || isnull _logic};
};
if (isnull _logic) exitwith {};


_typeCustom = _logic getvariable ["TypeCustom",""];
_win = _logic getvariable ["Win",true];
if ({isclass (_x >> "CfgDebriefing" >> _typeCustom)} count [configfile,campaignconfigfile,missionconfigfile] > 0) exitwith {
[[_typeCustom,_win],"bis_fnc_endMission"] call bis_fnc_mp;
};

_debriefing = missionnamespace getvariable [typeof _logic + "RscAttributeEndMission_debriefing",""];
RscDisplayDebriefing_params = _debriefing;
publicvariable "RscDisplayDebriefing_params";

_type = _logic getvariable ["Type",""];
_type call bis_fnc_endMissionServer;

RscDisplayDebriefing_params = _debriefing;
publicvariable "RscDisplayDebriefing_params";

if (count objectcurators _logic > 0) then {deletevehicle _logic};
};}