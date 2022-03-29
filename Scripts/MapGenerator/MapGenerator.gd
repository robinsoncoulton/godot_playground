extends Node

class_name MapGenerator

signal started
signal finished

var _width: int
var _height: int
var _tile_matrix: Array # 2D array of Tiles, index can be considered Coordinates
var _tile_set: TileSet

func _init(width, height, tile_set) -> void:
	emit_signal("started")
	self._width = width
	self._height = height
	self._tile_set = tile_set
	_generateTileMatrix()
	emit_signal("finished")
	
func _generateTileMatrix() -> void:
	var _generation = []
	print(_tile_set)
	print(_tile_set.find_tile_by_name("grass.png"))
	for x in range(0, _width):
		var _column = []
		for y in range(0, _height):
			var _tile = Tile.new(self._tile_set.find_tile_by_name("grass.png"), Vector2(x, y))
			_column.append(_tile)
		_generation.append(_column)	
		self._tile_matrix = _generation


func getHeight() -> int:
	return _height
	
func getWidth() -> int:
	return _width
	
func getTile(x: int, y: int) -> Tile:
	return _tile_matrix[x][y]

func getTileMatrix() -> Array:
	return _tile_matrix
