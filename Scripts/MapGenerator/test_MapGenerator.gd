extends 'res://addons/gut/test.gd'

var _tile_map
onready var _tile_set = MockedTileset.new()

func test_constructor():
	var _x = 12
	var _y = 12
	var _map = MapGenerator.new(_x, _y, _tile_set, Vector2(0,0), _tile_map)
	
	assert_eq(_map.getWidth(), _x)
	assert_eq(_map.getHeight(), _y)
	
	var _start = _map.getStart()
	var _goal = _map.getGoal()
	
	assert_not_null(_start)
	assert_not_null(_goal)
	assert_true(_start != _goal)
	assert_true(_start.x <= _x && _start.x >= 0)
	assert_true(_start.y <= _y  && _start.y >= 0)
	assert_true(_goal.x <= _x && _goal.x >= 0)
	assert_true(_goal.y <= _y && _goal.y >= 0)

func test_getTile():
	var _map = MapGenerator.new(12, 12, _tile_set, Vector2(0,0), _tile_map)
	var _tile: Tile = _map.getTile(1, 1)
	assert_eq(_tile.getTilesetTile(), 1)
	assert_eq(_tile.getCoordinates(), Vector2(1,1))
