extends 'res://addons/gut/test.gd'

onready var _tile_set = MockedTileset.new()

func test_constructor():
	var _map = MapGenerator.new(12, 12, _tile_set)
	
	assert_eq(_map.getWidth(), 12)
	assert_eq(_map.getHeight(), 12)

func test_getTile():
	var _map = MapGenerator.new(12, 12, _tile_set)
	var _tile: Tile = _map.getTile(1, 1)
	assert_eq(_tile.getTilesetTile(), 1)
	assert_eq(_tile.getCoordinates(), Vector2(1,1))
