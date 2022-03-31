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
var _doodad_layer: TileMap

func _init(width, height, tile_set, start_location, doodad_layer) -> void:
	emit_signal("started")
	self._width = width
	self._height = height
	self._tile_set = tile_set
	self._start = start_location
	self._goal = _generateGoalLocation()
	self._doodad_layer = doodad_layer
	_doodad_layer.clear()
	_generateTileMatrix()
	emit_signal("finished")
	
func _generateTileMatrix() -> void:
	var _doodads = _getDoodadsFromTileset()
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
				var _traversible = true
				if (randi() % 100 < 20):
					_traversible = false
					_doodad_layer.set_cell(x, y, _doodads[randi() % _doodads.size()])
				_tile = Tile.new(self._tile_set.find_tile_by_name("grass.png"), Vector2(x, y), _traversible)
			_column.append(_tile)
		_generation.append(_column)	
		self._tile_matrix = _generation
	

func _generateGoalLocation() -> Vector2:
	var _vector: Vector2 = _start
	while _vector == _start:
		_vector = Vector2(randi() % _width, randi() % _height)
	
	return _vector
	
func _getDoodadsFromTileset() -> Array:
	var _array = []
	_array.append(self._tile_set.find_tile_by_name("tree1.png"))
	_array.append(self._tile_set.find_tile_by_name("tree2.png"))
	_array.append(self._tile_set.find_tile_by_name("tree3.png"))
	_array.append(self._tile_set.find_tile_by_name("tree4.png"))
	_array.append(self._tile_set.find_tile_by_name("tree5.png"))
	_array.append(self._tile_set.find_tile_by_name("tree6.png"))
	_array.append(self._tile_set.find_tile_by_name("bush1.png"))
	_array.append(self._tile_set.find_tile_by_name("bush2.png"))
	_array.append(self._tile_set.find_tile_by_name("bush3.png"))
	_array.append(self._tile_set.find_tile_by_name("bush4.png"))
	_array.append(self._tile_set.find_tile_by_name("bush5.png"))
	_array.append(self._tile_set.find_tile_by_name("bush6.png"))
	return _array

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
	
		
