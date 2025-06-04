class_name CameraExecutor extends Action
var target_camera:Camera2D = null

func _init(target_camera_ref:Camera2D = null) -> void:
	if target_camera_ref != null:
		target_camera = target_camera_ref
	else:
		target_camera = GlobalEnvironment._get("main_camera")
		if target_camera == null:
			print("CameraExecutor: camera getting failure")
			
func shake_with_shock()->void:
	print("shake camera trigger")
	var duration = 1
	var intensity = 0.15
	# For testing
	var original_zoom = target_camera.zoom 
	target_camera.zoom = Vector2(target_camera.zoom.x + 1 , target_camera.zoom.y +1)
	
	await target_camera.get_tree().create_timer(duration).timeout
	target_camera.zoom = original_zoom

func execute(action_data:Dictionary)->void:
	#TBC
	shake_with_shock()
