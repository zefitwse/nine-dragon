extends Node2D
@onready var host_bar_slots = $CanvasLayer/hostbar

func _ready() -> void:
		#for slot in  host_bar_slots.get_children():
			#slot.connect("gui_input",slot_gui_input.bind(slot))
	initialize_inventory()
		
func initialize_inventory():
	var slots = host_bar_slots.get_children()
	for i in  slots.size():
		if PlayerInventory.hostbar.has(i):
			slots[i].initialize_item(PlayerInventory.hostbar.get(i)[0],PlayerInventory.hostbar.get(i)[1])
			
