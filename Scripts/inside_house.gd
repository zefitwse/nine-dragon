extends Node2D
@onready var entry_point:Node2D = $"Node2D/entry_point"
@onready var background:TileMapLayer = $background/background
var player

func _ready() -> void:
	player = scene_manager.player
	if player:
		self.add_child(player)	
	camera_init()
	
func camera_init()->void:
	var camera_node:follow_camera = get_node("MainCharacter/Camera2D")
	if camera_node:
		camera_node.refresh_limit(background)
