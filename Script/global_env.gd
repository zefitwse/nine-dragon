extends Node

var main_camera: Camera2D = null
var main_character: CharacterBody2D = null

func _set(property: StringName, value: Variant) -> bool:
	match property:
		"main_camera":
			main_camera = value
			return true
		"main_character":
			main_character = value
			return true
	return false
	
func _get(property: StringName) -> Variant:
	match property:
		"main_camera":
			return main_camera
		"main_character":
			return main_character
	return null
