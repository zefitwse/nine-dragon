class_name follow_camera extends Camera2D
@export var map_layer:Node2D
func init_camera():
	for bg in map_layer.get_children():
		if bg is TileMapLayer:
			if bg.name == "background":
				refresh_limit(bg)

func refresh_limit(bg:TileMapLayer):
	var mapRect = bg.get_used_rect()
	var tileSize = bg.get_rendering_quadrant_size()
	var worldSize = mapRect.size * tileSize
	limit_right = worldSize.x
	limit_bottom = worldSize.y
	
func _ready() -> void:
	init_camera()
	
func _process(delta: float) -> void:
	pass
