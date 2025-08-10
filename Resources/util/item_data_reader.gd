extends Node

var item_data:Array
var json_data: Array
@export var file_path = "res://data/inventory_data.json"

func _init() -> void:
	item_data =load_json_file(file_path)
	
func load_json_file(file_path:String):
	var file_data =FileAccess.get_file_as_string(file_path)
	json_data = JSON.parse_string(file_data)
	
	if json_data:
		return json_data
	return null
	
func _get_dict_object()-> Dictionary:
	var target_data:Dictionary
	for tem_item in json_data:
		target_data[int(tem_item["id"])] = tem_item
	return target_data
		
	
	
