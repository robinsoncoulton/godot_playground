extends Node
class_name GameWorld

signal started
signal finished

export var inner_size := Vector2(10, 8)
export var perimeter_size := Vector2(1, 1)
export (float, 0, 1) var ground_probability := 0.1

var size := inner_size + 2 * perimeter_size
onready var _tile_map: TileMap = $TileMap
var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	setup()

func setup() -> void:
	var map_size_px := size * _tile_map.cell_size
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, map_size_px)
	OS.set_window_size(2 * map_size_px)
	generate()

func generate() -> void:
	emit_signal("started")
	_generate_perimeter()
	_generate_inner()
	emit_signal("finished")
	
func _generate_perimeter() -> void:
	var dirt_tile = $TileMap.tile_set.find_tile_by_name("dirt.png")
	for x in [0, size.x - 1]:
		for y in range(0, size.y):
			_tile_map.set_cell(x, y, dirt_tile)
			
	for x in range(1, size.x - 1):
		for y in [0, size.y - 1]:
			_tile_map.set_cell(x, y, dirt_tile)
	
func _generate_inner() -> void:
	for x in range(1, size.x - 1):
		for y in range(1, size.y - 1):
			var cell := _get_random_tile(ground_probability)
			_tile_map.set_cell(x, y, cell)	
	
	
func _get_random_tile(probability: float) -> int:
	var grass_tile = $TileMap.tile_set.find_tile_by_name("grass.png")
	var water_tile = $TileMap.tile_set.find_tile_by_name("water.png")
	return water_tile if _rng.randf() < probability else grass_tile

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("confirm"):
		generate()
