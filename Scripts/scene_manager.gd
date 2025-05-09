class_name SceneManager extends Node
var player:Player
var scene_folder = "res://Scenes/"
func change_scene(body,from,to_scene):
 player = body
 var scene_path = scene_folder + to_scene + ".tscn"

 var old_scene = from.get_tree().current_scene
 old_scene.remove_child(body)

 var new_scene = load(scene_path).instantiate()
 if to_scene == "Game":
  if new_scene.has_node("MainCharacter"):
   new_scene.remove_child(new_scene.get_node("MainCharacter"))

 var entry_point = new_scene.get_node("Node2D/entry_point")
 player.position_update(entry_point.global_position)
 new_scene.add_child(player)

 global.transition_status = false
 from.get_tree().root.add_child(new_scene)
 old_scene.queue_free()
 from.get_tree().current_scene = new_scene
