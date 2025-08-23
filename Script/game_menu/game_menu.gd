extends CanvasLayer

func _ready():
	hide()  # 初始隐藏菜单

func _input(_event):
	if Input.is_action_just_pressed("close_set"):
		toggle_menu()

func toggle_menu():
	if visible:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true
