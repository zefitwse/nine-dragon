class_name Item extends Node2D
var id:int
var item_name: String
var description: String
var item_weight: float
var item_quantity: int
var stackable: bool
var icon_src_path:String
var target_item:Dictionary


#Just for testing
func _init() -> void:
	target_item =  JsonData._get_dict_object()
	
func increase_item_quantity(add_val):
	item_quantity += add_val
	$quantity.text = item_quantity
	
func decrease_item_quantity(decrease_val):
	item_quantity += decrease_val
	$quantity.text = item_quantity
	
func set_item(item_id,qty):
	self.id = item_id
	self.item_quantity = qty
	
	var item = target_item.get(item_id)
	if item == null:
		# warning alarm
		print("Item not exits")
	else:
		icon_src_path = item["SrcPath"]
		$item_icon.texture = load(icon_src_path)
		
		item_quantity = qty

		if item_quantity == 1:
			$quantity.visible = false
		else:
			$quantity.visible = true
			$quantity.text = str(item_quantity)
	
	
	
	
	
