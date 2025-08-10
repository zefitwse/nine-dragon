class_name SceneItem extends Item

@export var item_id:int
@onready var item_pic = $trigger_area/item_icon
@onready var trigger_area = $trigger_area
@onready var prompt_area= $prompt_container
@onready var prompt_text= $prompt_container/prompt

var prompt_view_flag = false
var original_y_position
var speed = 3
var amplitude = 6  #each pixel

func _init() -> void:
	super._init()
	
func _ready() -> void:
	_item_initialization()
	trigger_area.mouse_entered.connect(_on_mouse_enter)
	trigger_area.mouse_exited.connect(_on_mouse_exit)
	
	#set the current object parameters
	original_y_position = prompt_area.position.y
	prompt_text.text = item_name
	
func _item_initialization():
	var tem_item_obj = target_item.get(item_id)
	if tem_item_obj == null:
		print("Item not exist")
		return
		
	id = item_id
	item_name = tem_item_obj["ItemName"]
	icon_src_path = tem_item_obj["SrcPath"]
	item_pic.texture = load(icon_src_path)

func _process(delta: float) -> void:
	if prompt_view_flag:
		var offset = sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude
		prompt_area.position.y = original_y_position + offset

func _update_prompt_container():
	prompt_area.visible = prompt_view_flag

func _on_mouse_enter():
	prompt_view_flag = true
	_update_prompt_container()
	
func _on_mouse_exit():
	prompt_view_flag = false
	_update_prompt_container()
