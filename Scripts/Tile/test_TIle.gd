extends 'res://addons/gut/test.gd'

func test_constructor():

	var _tile = Tile.new(1, Vector2(0, 0))
	
	assert_eq(_tile.getTilesetTile(), 1)
	assert_eq(_tile.getTraversable(), true)
	assert_eq(_tile.getCoordinates(), Vector2(0, 0))

