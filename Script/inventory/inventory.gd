class_name Inventory extends Node2D
const slot_class = preload("res://Script/inventory/slot.gd")
@onready var inventory_slots = $bag
@onready var host_bar_slots = $hostbar
var holding_item = null
var tem_slot:Slot = null
var global_host_bar:HostBar;

func _ready() -> void:
	
	global_host_bar = GlobalEnvironment._get("host_bar")
	# To connect event listener between the slot components
	initialize_slot()
	initialize_inventory()
	
func initialize_slot():
	var slot_index = 0
	for slot in host_bar_slots.get_children():
		#define the slot id
		slot.slot_index = slot_index
		slot.connect("gui_input",slot_gui_input.bind(slot))
		slot_index += 1
		
	for slot in inventory_slots.get_children():
		slot.slot_index = slot_index
		slot.connect("gui_input",slot_gui_input.bind(slot))
		slot_index += 1
		
func initialize_inventory():
	var host_bar_slots = host_bar_slots.get_children()
	for i in host_bar_slots.size():
		if PlayerInventory.inventory.has(i):
			host_bar_slots[i].initialize_item(PlayerInventory.inventory.get(i)[0],PlayerInventory.inventory.get(i)[1],i)
			
	var inventory_slots = inventory_slots.get_children()	
	for i in  range(host_bar_slots.size(),inventory_slots.size()):
		if PlayerInventory.inventory.has(i):
			inventory_slots[i].initialize_item(PlayerInventory.inventory.get(i)[0],PlayerInventory.inventory.get(i)[1],i)
	
			
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
					tem_slot.pick_from_slot()
					#temp_item.global_position = event.global_position
					tem_slot.put_into_slot(temp_item)
					slot.put_into_slot(holding_item)
					holding_item = null
					#holding_item = temp_item
					#tem_slot = slot
				PlayerInventory.swap_item_position(tem_slot.slot_index,slot.slot_index)
				# handle the host bar state
				global_host_bar.refresh_slot()
					
					
			elif slot.item:
				holding_item = slot.item
				#Remark the item's slot
				tem_slot = slot
				slot.pick_from_slot()
				holding_item.global_position = get_global_mouse_position()
		
func _input(event: InputEvent) -> void:
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
	
	
