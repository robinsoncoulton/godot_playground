extends Node

class_name Tile

var _tilesetTile: int
var _traversable: bool
var _coordinate: Vector2

func _init(tilesetTile: int, coordinate: Vector2, traversable: bool = true) -> void:
	self._tilesetTile = tilesetTile
	self._traversable = traversable
	self._coordinate = coordinate

func getTilesetTile() -> int:
	return self._tilesetTile
	
func getTraversable() -> bool:
	return self._traversable
	
func getCoordinates() -> Vector2:
	return self._coordinate
