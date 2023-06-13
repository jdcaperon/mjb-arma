params ["_target", "_caller"];

private _center = "";
private _targets = [];
if (_target == khComputer) then {_center = iCenter;} else {_center = iRange;};
if (_center == iCenter) then {

  _targets = nearestObjects [position _center, ["TargetBase"], 50];
  if (count _targets < 1) exitWith {
    ["No compatible targets were found."] remoteExec ["systemChat", _caller];
  };
  {_x animate ["Terc",0];} forEach _targets;
  {_x addEventHandler ["HIT", {
    (_this select 0) animate ["Terc",1];
    (_this select 0) RemoveEventHandler ["HIT",0];
  }
  ]} forEach _targets;

  ["Killhouse has been reset."] remoteExec ["systemChat", _caller]; // shows trigger message (remove // behind systemChat to see the text ingame)
} else {
  _targets = nearestObjects [position _center, ["TargetBase"], 1100];
  if (count _targets < 1) exitWith {
    ["No compatible targets were found."] remoteExec ["systemChat", _caller];
  };
  {_x animate ["Terc",0];} forEach _targets;
  ["Range has been reset."] remoteExec ["systemChat", _caller];
};