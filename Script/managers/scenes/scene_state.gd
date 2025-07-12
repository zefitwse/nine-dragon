extends Node
# 维护所有变量和场景路径的映射关系
@export var inner_scene: String = "res://Scenes/game_scenes/inner_scene.tscn" 
@export var outdoor_scene: String = "res://Scenes/game_scenes/outdoor_scene.tscn"  
@export var inner_scene_1: String = "res://Scenes/game_scenes/InnerScene.tscn" 

#定义scene_status的取值范围 can_enter 解锁（可进入）、not_enter 未解锁（不可进入）、done 完成（可进入）
enum scene_status { can_enter, not_enter, done }  

#scene_status字典
var scene_states: Dictionary = {
	outdoor_scene: scene_status.can_enter,
	inner_scene: scene_status.can_enter,
}

#判断场景是否可进入，返回true表示可进入
func is_scene_can_enter(scene_path: String) -> bool:
	#get的第二个参数表示默认值。当字典里找不到这个对象的时候，就返回默认值
	return scene_states.get(scene_path, scene_status.can_enter) == scene_status.can_enter

#解锁场景
func unlock_scene(scene_path: String) -> void:
	if scene_states.has(scene_path):
		scene_states[scene_path] = scene_status.not_enter

#完成场景
func complete_scene(scene_path: String) -> void:
	if scene_states.has(scene_path):
		scene_states[scene_path] = scene_status.done
		#_unlock_next_scene(scene_path)

#解锁下一个场景
func _unlock_next_scene(scene_path: String) -> void:
	var keys = scene_states.keys()
	var index = keys.find(scene_path)
	if index != -1 and index + 1 < keys.size():
		var next_scene = keys[index + 1]
		if scene_states[next_scene] == scene_status.can_enter:
			scene_states[next_scene] = scene_status.not_enter

#保存进度
func save_progress():
	var config = ConfigFile.new()
	for scene_path in scene_states:
		config.set_value("scenes", scene_path, scene_states[scene_path])
	config.save("user://progress.cfg")

#读取进度
func load_progress():
	var config = ConfigFile.new()
	if config.load("user://progress.cfg") != OK:
		return
	for scene_path in scene_states:
		if config.has_section_key("scenes", scene_path):
			scene_states[scene_path] = int(config.get_value("scenes", scene_path))
