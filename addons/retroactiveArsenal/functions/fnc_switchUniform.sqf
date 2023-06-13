params ["_player",["_uniform",""]];

if (_uniform isEqualTo "") then {_uniform = (uniform _player)};
private _uniformContent = uniformContainer _player;
private _items = itemCargo _uniformContent;
private _mags = magazinesAmmoCargo _uniformContent;
private _weps = weaponsItemsCargo _uniformContent;

_player forceAddUniform _uniform;
_uniformContent = uniformContainer _player;
{ _uniformContent addItemCargoGlobal [_x, 1] } forEach _items;
{	private _mag = +_x;
	_mag set [2, (_mag select 1)]; _mag set [1,1];
	_uniformContent addMagazineAmmoCargo _mag;
} forEach _mags;
{ _uniformContent addWeaponWithAttachmentsCargoGlobal [_x, 1] } forEach _weps;