class_name ActionManager extends Node

enum ActionType {CAMERA,SOUND}
var action_list = {}

func _ready()-> void:
	action_list[ActionType.CAMERA] = CameraExecutor.new() as Action
	action_list[ActionType.SOUND] = SoundExecutor.new() as Action
	
func execute(action_data:Dictionary)->void:
	# Camera component handling
	var camera_effect = action_data.get("camera_effect",null)
	var sound_effect = action_data.get("sound_effect",null)
	
	if sound_effect != null:
		var sound_executor:SoundExecutor = action_list[ActionType.SOUND]
		await sound_executor.execute(sound_effect)
	
	if camera_effect != null:
		var camera_executor:CameraExecutor = action_list[ActionType.CAMERA]
		await camera_executor.execute(camera_effect)
	
	
	
	# other handling: sound, visual, character... TBC
	
