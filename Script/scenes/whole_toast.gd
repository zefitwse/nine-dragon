extends CanvasLayer

@onready var panel_container = $PanelContainer
@onready var label = $PanelContainer/Label

var display_time := 2.0;

func show_toast(message: String, display_time := 2.0) -> void:
	label.text = message
	panel_container.visible = true
	await get_tree().create_timer(display_time).timeout
	panel_container.visible = false
	
