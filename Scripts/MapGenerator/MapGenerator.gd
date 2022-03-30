extends Node

class_name MapGenerator

signal started
signal finished

var _width: int
var _height: int
var _tile_matrix: Array # 2D array of Tiles, index can be considered Coordinates
var _tile_set: TileSet
var _start: Vector2
var _goal: Vector2

func _init(width, height, tile_set) -> void:
	emit_signal("started")
	self._width = width
	self._height = height
	self._tile_set = tile_set
	self._start = _generateStartLocation()
	self._goal = _generateGoalLocation()
	_generateTileMatrix()
	emit_signal("finished")
	
func _generateTileMatrix() -> void:
	var _generation = []
	for x in range(0, _width):
		var _column = []
		for y in range(0, _height):
			var _tile
			if x == _start.x && y == _start.y:
				_tile = Tile.new(self._tile_set.find_tile_by_name("dirt.png"), Vector2(x, y))
			elif x == _goal.x && y == _goal.y:
				_tile = Tile.new(self._tile_set.find_tile_by_name("water.png"), Vector2(x, y))
			else:
				_tile = Tile.new(self._tile_set.find_tile_by_name("grass.png"), Vector2(x, y))
			_column.append(_tile)
		_generation.append(_column)	
		self._tile_matrix = _generation
		
func _generateStartLocation() -> Vector2:
	return Vector2(randi() % _width, randi() % _height)

func _generateGoalLocation() -> Vector2:
	var _vector: Vector2 = _start
	while _vector == _start:
		_vector = Vector2(randi() % _width, randi() % _height)
	
	return _vector

func getHeight() -> int:
	return _height
	
func getWidth() -> int:
	return _width
	
func getTile(x: int, y: int) -> Tile:
	return _tile_matrix[x][y]

func getTileMatrix() -> Array:
	return _tile_matrix

func getStart() -> Vector2:
	return _start
	
func getGoal() -> Vector2:
	return _goal
	
		
