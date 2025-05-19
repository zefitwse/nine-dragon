#场景切换脚本
extends Node2D
@export_file("*.tscn") var target_scene_path: String = SceneManager.inner_scene #SceneManager负责维护所有场景路径和场景变量名的映射

#源：DoorArea2D 
#目标： OuterdoorScene
func _on_door_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#PlayerState.health 这里可以调用PlayerState单例，在切换前，更新一下单例的最新值，方便进入下一个场景的时候，再用单例赋值
		get_tree().change_scene_to_file(target_scene_path)
	pass 
