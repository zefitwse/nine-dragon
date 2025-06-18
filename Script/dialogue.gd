@tool
extends Resource
class_name Dialogue
@export_category("Information")
var msg_id: int
var name: String
var dialogue: String
var icon_path:String
var msg_content:String
var source_path: String
var option_msg: String
var options: Array
var id_to_dialogue: Dictionary = {}

func load_dialogues():
	# 使用 FileAccess 替代 File
	if FileAccess.file_exists(source_path):
		var file = FileAccess.open(source_path, FileAccess.READ)
		if file:
			var json_data = file.get_as_text()
			file.close()
			parse_json(json_data)
		else:
			print("无法打开文件:", source_path)
	else:
		print("文件不存在:", source_path)

# 解析 JSON 数据
func parse_json(json_string: String) -> Array:
	var json = JSON.new()
	var result = json.parse(json_string)
	#id_to_dialogue = {}
	
	if result == OK:
		var dialogues = []
		var options=[]
		for dialogue_data in json.get_data():
			var new_dialogue = Dialogue.new()
			new_dialogue.msg_id =  dialogue_data["msg_id"]
			new_dialogue.name = dialogue_data["name"]
			new_dialogue.msg_content = dialogue_data["msg_content"]
			new_dialogue.icon_path = dialogue_data["icon_path"]
			new_dialogue.options = dialogue_data.get("options", [])

			dialogues.append(new_dialogue)
			id_to_dialogue[new_dialogue.msg_id] = new_dialogue
		return dialogues
	else:
		print("JSON 解析错误:", json.get_error_text()) 
		return []
	
func get_dialogue_id_mapping(json_file_path:String) -> Dictionary:
	source_path = json_file_path
	load_dialogues()
	return id_to_dialogue
