class_name Inventory extends Node2D
const slot_class = preload("res://Script/inventory/slot.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null

func _ready() -> void:
	# To connect event listener between the slot components
	if inventory_slots == null:
		print("WARNING: Inventory_slots isn't exist")
	else:
		for slot in  inventory_slots.get_children():
			slot.connect("gui_input",slot_gui_input.bind(slot))

func slot_gui_input(event: InputEvent, slot:Slot):
	if event is InputEventMouseButton:
		# Button pressed and the mouse key is left
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					slot.put_into_slot(holding_item)
					holding_item = null
				else:
					var temp_item = slot.item
					slot.pick_from_slot()
					temp_item.global_position = event.global_position
					slot.put_into_slot(holding_item)
					holding_item = temp_item
			elif slot.item:
				holding_item = slot.item
				slot.pick_from_slot()
				holding_item.global_position = get_global_mouse_position()
		
func _input(event: InputEvent) -> void:
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
	
	
