extends Node

const NUM_INVENTORY_SLOTS = 7 
enum SlotType {HOSTBAR, INVENTORY}

var inventory = {
	0:[1,23], # slot index -> item id and quantity
	1:[3,11],
	2:[2,1]
}


func add_item(item_id,qty):
	for item in inventory:
		if inventory[item][0] == item_id:
			inventory[item][1] += qty
			return
	#item not exist in inventory
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_id,qty]
			return
			
func swap_item_position(from,to):
	if inventory.has(to):
		var tem_slot_info = inventory[to]
		inventory[to]=inventory.get(from)
		inventory[from] = tem_slot_info
	else:
		inventory[to]=inventory.get(from)
		inventory.erase(from)
		
