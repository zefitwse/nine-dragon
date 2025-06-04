class_name ActionManager extends Node

enum ActionType {CAMERA_SHAKE}
var action_list = {}

func _init() -> void:
	action_list[ActionType.CAMERA_SHAKE] = CameraExecutor.new() as Action

func execute(action_data:Dictionary)->void:
	# Camera component handling
	var camera_effect = action_data.get("camera_effect",null)
	
	if camera_effect != null:
		var camera_executor:CameraExecutor = action_list[ActionType.CAMERA_SHAKE]
		camera_executor.execute(camera_effect)
	
	# other handling: sound, visual, character... TBC
	
