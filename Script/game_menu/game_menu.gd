extends CanvasLayer


#菜单初始化的时候，要获取音量的设置值
func _ready():
	var volume = SettingsManager.load_volume()
	$GameMenu/MenuPanel/VBoxContainer/VBoxContainer/VoiceHBoxContainer/VoiceSlider.value = volume
	_on_voice_slider_value_changed(volume)
	
	hide()  # 初始隐藏菜单
	

#监听esc按下事件
func _input(_event):
	if Input.is_action_just_pressed("close_set"):
		toggle_menu()

#显示或者隐藏menu
func toggle_menu():
	if visible:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true

# 继续游戏
func _on_resume_button_pressed() -> void:
	hide()	
	get_tree().paused = false
	pass # Replace with function body.

# 退出游戏
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

#保存游戏
func _on_save_button_button_down() -> void:
	print("saved game")
	pass # Replace with function body.
	
#调节音量
func _on_voice_slider_value_changed(value: float) -> void:
	var db = lerp(-30.0, 0.0, value / 100.0)
	var bus_idx = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_idx, db)
	SettingsManager.save_volume(value)  # 更新保存
	
