# DoorArea.gd
extends Area2D

#export(String, FILE, "*.tscn") var target_scene_path = "res://Scenes/InnerScene.tscn"

func _on_DoorArea_body_entered(body):
	print('aaaaaaa')
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/InnerScene.tscn")
