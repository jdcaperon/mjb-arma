#include "settings.sqf"
if (!isDedicated && {mjb_perks}) then {
    call mjb_perks_fnc_perkSelect;
};