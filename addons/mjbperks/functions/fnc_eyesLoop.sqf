

private _camera = "camera" camCreate (positionCameraToWorld  [0,0,0]);
_camera attachTo [player];
_camera cameraEffect ["INTERNAL","FRONT","mjb_eyessurface"];
private _renderTexture = "#(argb,512,512,1)r2t(mjb_eyessurface,1.333)";

(["mjb_eyeLayer"] call BIS_fnc_rscLayer) cutRsc ["RscDisplayNone", "PLAIN",-1,false];
private _display = uiNamespace getVariable ["mjb_eyeLayer", displayNull];

private _screenAR = getResolution select 4;
private _camEffect = [0];
private _camFov = 0.75;
mjb_eyesEnd = false;
while {alive player && {!mjb_eyesEnd}} do {
    waitUntil {mjb_eyesEnd || {inputAction "ZoomTemp" > 0 && {!mjb_aiming && {vehicle player == player}}}};
    private _camDir = getCameraViewDirection player;
    private _vehicle = (vehicle player);
    private _hidden = isServer || {isHidden _vehicle};
    if !(_hidden) then {_vehicle hideObject true;};
	//_viewBox setObjectTexture [0, _renderTexture];
    _camera camSetDir _camDir;
	private _playerFoV = getObjectFOV player;
	cameraEffectEnableHUD true;
	_camera camSetFov _playerFoV;
    _camera camCommit 0;
    waitUntil { camCommitted _camera };

	private _fps = (1/60);

    while {inputAction "ZoomTemp" > 0} do {
		_playerFoV = _playerFoV * 0.98;
        _camera camSetFov (_playerFoV max 0.08333);
		_camera camCommit _fps;
		waitUntil { camCommitted _camera };
    };

    if !(_hidden) then {_vehicle hideObject false;};
	cameraEffectEnableHUD false;
    _camera cameraEffect ["TERMINATE","FRONT","mjb_eyessurface"];
};