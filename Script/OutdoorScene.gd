# 外部场景角色脚本（main_scene.gd）
extends Node2D

@export_file("*.tscn") var target_scene_path: String = "res://Scenes/InnerScene.tscn"

func _on_door_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file(target_scene_path)
	pass 
