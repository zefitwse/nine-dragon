#场景切换脚本
extends Node2D

@export_file("*.tscn") var target_scene_path: String = SceneManager.inner_scene_dr #SceneManager负责维护所有场景路径和场景变量名的映射


#初始化的时候要加载用户的设置，比如游戏声音大小
func _ready() -> void:
	var volume = SettingsManager.load_volume()      # 读取保存的音量
	var db = lerp(-30.0, 0.0, volume / 100.0)
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_idx, db)


#源：DoorArea2D 
#目标： OuterdoorScene
func _on_door_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#PlayerState.health 
		#这里可以调用PlayerState单例，在切换前，更新一下单例的最新值，方便进入下一个场景的时候，再用单例赋值
		var flag = SceneManager.is_scene_can_enter(target_scene_path);
		if(flag):
			get_tree().change_scene_to_file(target_scene_path);
		else:
			GlobalMessage_tscn.show_global_message("你还不能进入这个场景！",2.0)
	pass 
