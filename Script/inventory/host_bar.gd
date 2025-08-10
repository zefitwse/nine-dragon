class_name HostBar extends Node2D
@onready var host_bar_slots = $hostbar

var selected_slot:Slot
func _ready() -> void:
	GlobalEnvironment._set("host_bar",self)
	for slot in  host_bar_slots.get_children():
		slot.connect("gui_input",slot_input.bind(slot))
	initialize_inventory()
		
func initialize_inventory():
	var slots = host_bar_slots.get_children()
	for i in slots.size():
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory.get(i)[0],PlayerInventory.inventory.get(i)[1],i)
		else:
			slots[i].clear_item()

					
# Item click event
# TBC
func slot_input(event: InputEvent, slot:Slot):
	if event is InputEventMouseButton:
		# Button pressed and the mouse key is left
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			# Click event of slot and check the item whether grab
			if slot.item != null and selected_slot != slot:
				# change the slot background: highlight the grab effect
				if selected_slot != null:
					selected_slot.change_focus()
				
				# redefine the selected slot
				selected_slot = slot
				selected_slot.change_focus()
				
func refresh_slot():
	initialize_inventory()
