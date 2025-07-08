extends Node

var item_data:Array
@export var file_path = "res://data/inventory_data.json"
func _ready() -> void:
	item_data =load_json_file(file_path)
	
func load_json_file(file_path:String):
	var json_data: Array
	var file_data =FileAccess.get_file_as_string(file_path)
	json_data = JSON.parse_string(file_data)
	if json_data:
		return json_data
	return null
		
	
	
