class_name Slot extends Panel

const item_class = preload("res://Scenes/inventory/Item.tscn")
var slot_index
var item:Item = null
var empty_style_box:StyleBoxFlat = null
var default_style_box:StyleBoxFlat = null
var highlight_box:StyleBoxFlat = null

var selected_state: bool = false

func _ready() -> void:
	empty_style_box = StyleBoxFlat.new()
	default_style_box = StyleBoxFlat.new()
	highlight_box = StyleBoxFlat.new()
	highlight_box.set_bg_color(Color(0,229,238,1))

	#if randi() % 2 == 0:
		#item = item_class.instantiate()
		#self.add_child(item)
		
	refresh_style()
	
func refresh_style():
	if item == null:
		set("theme_override_styles/panel",empty_style_box)
	else:
		set("theme_override_styles/panel",default_style_box)

func pick_from_slot():
	remove_child(item)
	find_parent("Inventory").add_child(item)
	item = null
	refresh_style()

func put_into_slot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	find_parent("Inventory").remove_child(item)
	add_child(item)
	refresh_style()

func change_focus():
	if !selected_state:
		set("theme_override_styles/panel",highlight_box)
	else:
		set("theme_override_styles/panel",default_style_box)
	selected_state = !selected_state
	

func clear_item():
	if item != null:
		remove_child(item)
		item = null
		refresh_style()
		
func initialize_item(item_id,item_quantity,index):
	slot_index = index
	if item == null:
		item = item_class.instantiate()
		add_child(item)
	
	item.set_item(item_id,item_quantity)
	refresh_style()
	
