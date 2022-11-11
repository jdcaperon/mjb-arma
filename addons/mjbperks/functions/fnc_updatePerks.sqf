params ["_perkName"];

mjb_activePerks pushBack _perkName;
mjb_pP = mjb_pP - (missionNamespace getVariable [("mjb_" + _perkName + "Points"),0]);
// banzer line