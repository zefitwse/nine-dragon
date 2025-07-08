class_name Item extends Node2D
var id:int
var item_name: String
var description: String
var item_weight: float
var item_quantity: int
var stackable: bool

#Just for testing
func _ready() -> void:
	var inventory_data:Array = JsonData.item_data
	var item
	#just for testing
	if randi() % 2 == 0:
		# Three item for testing
		id = (randi() % 3) + 1
		for item_tem in inventory_data:
			if item_tem["id"] == id:
				item = item_tem
				break
				
		if item == null:
			# warning alarm
			print("Item not exits")
		else:
			$item_icon.texture = load(item["icon_src_path"])
			item_quantity = item["StackSize"]
			
			if item_quantity == 1:
				$quantity.visible = false
			else:
				$quantity.visible = true
				$quantity.text = item_quantity
		
		
		
func increase_item_quantity(add_val):
	item_quantity += add_val
	$quantity.text = item_quantity
	
func decrease_item_quantity(decrease_val):
	item_quantity += decrease_val
	$quantity.text = item_quantity
