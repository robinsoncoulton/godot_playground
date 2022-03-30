extends Node
class_name GameWorld

signal started
signal finished

var _map: MapGenerator
var _player: Player

export var x_size := 12
export var y_size := 12

var size := Vector2(x_size, y_size)

onready var _tile_map: TileMap = $GroundLayer
onready var _player_layer: TileMap = $PlayerLayer

func _ready() -> void:
	_setup()

func _setup() -> void:
	_tile_map.clear()
	_player_layer.clear()
	var map_size_px := size * _tile_map.cell_size
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, map_size_px)
	OS.set_window_size(2 * map_size_px)
	_generateRandomMap(Vector2(randi() % x_size, randi() % x_size))
	_renderMap()
	_setPlayerStart()
	
	
func _generateRandomMap(startLocation: Vector2) -> void:
	_map = MapGenerator.new(x_size, x_size, _tile_map.tile_set, startLocation)
	
func _renderMap() -> void:
	emit_signal("started")
	for mapRow in _map.getTileMatrix():
		for cell in mapRow: 
			_tile_map.set_cell(cell.getCoordinates().x, cell.getCoordinates().y, cell.getTilesetTile())
	emit_signal("finished")
	
func _setPlayerStart() -> void:
	_player = Player.new(_player_layer.tile_set, _map.getStart(), size)
	_player_layer.set_cell(_player.getCoordinates().x, _player.getCoordinates().y, _player.getSprite())
	
func _renderPlayerMove() -> void:
	_player_layer.clear()
	_player_layer.set_cell(_player.getCoordinates().x, _player.getCoordinates().y, _player.getSprite())
	if _player.getCoordinates() == _map.getGoal():
		_generateRandomMap(_map.getGoal())
		_renderMap()
#
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("confirm"):
		_setup()
		
	if event.is_action_pressed("move_north"):
		_player.moveNorth()
		_renderPlayerMove()
		
	if event.is_action_pressed("move_east"):
		_player.moveEast()	
		_renderPlayerMove()
		
	if event.is_action_pressed("move_west"):
		_player.moveWest()
		_renderPlayerMove()
		
	if event.is_action_pressed("move_south"):
		_player.moveSouth()
		_renderPlayerMove()
		
