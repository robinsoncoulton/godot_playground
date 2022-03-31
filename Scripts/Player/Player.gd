extends Node

class_name Player

var _sprite: int
var _coordinates: Vector2
var _bounds: Vector2
var _doodads: TileMap

func _init(sprite: TileSet, coordinates, bounds, doodads) -> void:
	self._sprite = sprite.find_tile_by_name('s.png')
	self._coordinates = coordinates
	self._bounds = bounds
	self._doodads = doodads


func getCoordinates() -> Vector2:
	return _coordinates

func getSprite() -> int:
	return _sprite
	
func moveNorth() -> void:
	var nextMove = Vector2(_coordinates.x, _coordinates.y - 1)
	if _detectTileCollision(nextMove):
		return
	if _coordinates.y - 1 >= 0:
		_coordinates = nextMove
	
func moveEast() -> void:
	var nextMove = Vector2(_coordinates.x + 1, _coordinates.y)
	if _detectTileCollision(nextMove):
		return
	if _coordinates.x + 1 < _bounds.x:
		_coordinates = nextMove
	
func moveSouth() -> void:
	var nextMove = Vector2(_coordinates.x, _coordinates.y + 1)
	if _detectTileCollision(nextMove):
		return
	if _coordinates.y + 1 < _bounds.y:
		_coordinates = nextMove
	
func moveWest() -> void:
	var nextMove = Vector2(_coordinates.x - 1, _coordinates.y)
	if _detectTileCollision(nextMove):
		return
		
	if _coordinates.x - 1 >= 0:
		_coordinates = nextMove		

func _detectTileCollision(nextMove: Vector2) -> bool:
	if _doodads.get_cell(nextMove.x, nextMove.y) >= 0:
		return true
	else:
		return false
