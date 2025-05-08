# SceneManager.gd
extends Node

func transition_to(scene_path: String):
	get_tree().change_scene_to_file(scene_path)
