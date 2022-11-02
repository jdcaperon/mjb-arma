while {alive player} do {
    waitUntil {inputAction "ZoomTemp" > 0 && {cameraView == "INTERNAL" && {vehicle player == player}}};

    private _camDir = getCameraViewDirection player;
    private _vehicle = (vehicle player);
    private _hidden = isServer || {isHidden _vehicle};
    if !(_hidden) then {_vehicle hideObject true;};
    private _camera = "camera" camCreate (positionCameraToWorld  [0,0,0]);
    _camera camSetDir _camDir;
	private _playerFoV = getObjectFOV player;
	_camera camSetFov _playerFoV;
    _camera camCommit 0;
    waitUntil { camCommitted _camera };
    _camera cameraEffect ["INTERNAL","FRONT"];

	private _fps = (1/60);

    while {inputAction "ZoomTemp" > 0} do {
		_playerFoV = _playerFoV * 0.98;
        _camera camSetFov (_playerFoV max mjb_beagModeZoom);
		_camera camCommit _fps;
		waitUntil { camCommitted _camera };
    };

    if !(_hidden) then {_vehicle hideObject false;};
    _camera cameraEffect ["TERMINATE","FRONT TOP"];
    camDestroy _camera;
};