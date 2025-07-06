class_name CameraExecutor extends Action
var target_camera:Camera2D = null

func _ready():
	rng.randomize() 

#func shake_with_shock()->void:
	#var duration = 1
	#var intensity = 0.15
	## For testing
	#var original_zoom = target_camera.zoom 
	#target_camera.zoom = Vector2(target_camera.zoom.x + 1 , target_camera.zoom.y +1)
	#
	#await target_camera.get_tree().create_timer(duration).timeout
	#target_camera.zoom = original_zoom
var rng = RandomNumberGenerator.new()

func shake_with_shock()->void:
	if not target_camera:
		return

	var duration = 1.0  # 震动持续4秒
	var start_strength = 8.0  # 初始震动强度
	var end_strength = 1.0# 结束时震动强度
	var elapsed = 0.0

	# 记录初始偏移量，震动结束后恢复
	var original_offset = target_camera.offset
	var tree = target_camera.get_tree()
	
	while elapsed < duration:
		# 记录当前时间，等待下一帧后计算delta
		var start_time = Time.get_ticks_msec()
		await tree.process_frame  # 等待一帧
		var delta = (Time.get_ticks_msec() - start_time) / 1000.0  # 转换为秒

		# 更新已流逝时间
		elapsed += delta
		# 计算当前震动强度（随时间衰减）
		var t = clampf(elapsed / duration, 0, 1)
		var current_strength = lerp(start_strength, end_strength, t)

		# 随机震动偏移
		var offset_x = rng.randf_range(-current_strength, current_strength)
		var offset_y = rng.randf_range(-current_strength, current_strength)
		target_camera.offset = original_offset + Vector2(offset_x, offset_y)

	# 震动结束后恢复原始位置
	target_camera.offset = original_offset

func execute(action_data:Dictionary)->void:
	target_camera = GlobalEnvironment._get("main_camera")
	if target_camera == null:
		print("CameraExecutor: camera getting failure")
	#TBC
	var action = action_data.get("action","null") 
	if action != null and action == "shake":
		shake_with_shock()
