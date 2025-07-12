extends Node2D

#这$（美元符号）， 作用是获取子节点，注意别重名
@onready var label = $use_keyboard_E_tip
@onready var area = $notice_board_area_2d

@onready var panel = get_node("../../../join_us_canvas_layer/Panel")

#玩家是否在范围内，在的话，按E有效，否则无效
var player_in_range = false;

#靠近
func _on_notice_board_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.visible = true
		player_in_range = true
	pass # Replace with function body.

#远离
func _on_notice_board_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		label.visible = false
		player_in_range = false
	pass # Replace with function body.
	
func _ready():
	label.visible = false  # 初始隐藏提示

func _process(_delta):
	if !player_in_range:
		panel.visible = false
		
	#当按下键盘E绑定的事件。这里我在autoload里，给按下E的交互命名为interact_notice_board
	if player_in_range and Input.is_action_just_pressed("interact_notice_board"):
		panel.visible = true
		#get_tree().paused = true  # （可选）暂停游戏
	

func _on_close_button_pressed() -> void:
	#get_tree().paused = false
	panel.visible = false
	pass # Replace with function body.
