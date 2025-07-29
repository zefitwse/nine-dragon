class_name UserInterface extends CanvasLayer
@onready var host_bar = $HostBar
@onready var inventory = $Inventory
var inventory_display_flage = false

# TBC: keypress handling
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		# Judge the input keycode whether equal to setting
		if InputMap.event_is_action(event,"show_inventory") and event.pressed:
			if !inventory_display_flage:
				host_bar.visible = false
				inventory.visible = true
			else:
				host_bar.visible = true
				inventory.visible = false
				
			inventory_display_flage = !inventory_display_flage
