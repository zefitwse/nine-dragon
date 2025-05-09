class_name SceneController extends Area2D

@export var connected_scene:String
func _on_body_entered(body) -> void:
	if (body is Player) and global.transition_status:
		scene_manager.change_scene(body,get_owner(),connected_scene)
	
func _on_body_exited(body: Node2D) -> void:
	global.transition_status = true
	
