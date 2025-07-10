extends Node2D
@onready var host_bar_slots = $CanvasLayer/hostbar

func _ready() -> void:
	#if host_bar_slots == null:
		#print("WARNING: Inventory_slots isn't exist")
	#else:
		#for slot in  host_bar_slots.get_children():
			#slot.connect("gui_input",slot_gui_input.bind(slot))
	pass
