class_name SoundExecutor extends Action


func execute(action_data:Dictionary)->void:
	var src_path = action_data.get("src_path",null)
	var tree = GlobalEnvironment.main_camera.get_tree().current_scene
	
	if src_path and ResourceLoader.exists(src_path):
		var sound_stream: AudioStream = load(src_path)
		var player = AudioStreamPlayer.new()
		tree.add_child(player)
		player.stream = sound_stream
		
		var timer = Timer.new()
		tree.add_child(timer)
		timer.wait_time = 3.0
		timer.timeout.connect(func():
			if player.is_inside_tree():
				player.stop()
				player.queue_free()
			timer.queue_free()
		)
		
		player.play()
		timer.start()
	
