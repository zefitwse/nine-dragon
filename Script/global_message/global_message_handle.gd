extends CanvasLayer

@onready var message_label: Label = $Control/Panel/Label

func show_global_message(text: String, duration: float = 2.0) -> void:
	message_label.text = text
	self.show()   # 显示整个 CanvasLayer

	if duration > 0:
		await get_tree().create_timer(duration).timeout
		hide_global_message()

func hide_global_message() -> void:
	self.hide()   # 隐藏整个 CanvasLayer
