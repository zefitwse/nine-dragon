extends Camera2D
@export var target: Node2D     # 拖拽角色节点到此变量
@export var smooth_speed = 5.0

func _init():
	var setting_result = GlobalEnvironment._set("main_camera",self)
	if not setting_result: 
		print("camera init failure")
		
func _process(delta):
	if target:
		position = position.lerp(target.position, delta * smooth_speed)
