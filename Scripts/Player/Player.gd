extends Node

class_name Player

var _sprite: int
var _coordinates: Vector2
var _bounds: Vector2

func _init(sprite: TileSet, coordinates, bounds) -> void:
	self._sprite = sprite.find_tile_by_name('s.png')
	self._coordinates = coordinates
	self._bounds = bounds


func getCoordinates() -> Vector2:
	return _coordinates

func getSprite() -> int:
	return _sprite
	
func moveNorth() -> void:
	if _coordinates.y - 1 >= 0:
		_coordinates = Vector2(_coordinates.x, _coordinates.y - 1)
	
func moveEast() -> void:
	if _coordinates.x + 1 < _bounds.x:
		_coordinates = Vector2(_coordinates.x + 1, _coordinates.y)
	
func moveSouth() -> void:
	if _coordinates.y + 1 < _bounds.y:
		_coordinates = Vector2(_coordinates.x, _coordinates.y + 1)
	
func moveWest() -> void:
	if _coordinates.x - 1 >= 0:
		_coordinates = Vector2(_coordinates.x - 1, _coordinates.y)		
