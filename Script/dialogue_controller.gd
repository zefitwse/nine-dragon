class_name DialogueController extends CanvasLayer
@onready var character_name = %dialogue_msg_info/%name
@onready var msg_content = %dialogue_msg_info/%text_content
@onready var dialogue_panel = %dialogue_panel
@onready var choosing_box = %dialogue_msg_info/%choosing_box
@onready var player = get_tree().current_scene.get_node("MainCharacter")
@onready var game_scene = get_tree().current_scene
@export var json_src_path: String

var is_typing = false
var current_dialogue_id:int
var current_dialogue:Dialogue
var dialogue:Dialogue
var tween
var option_box_enable = false
var id_map_dialogue:Dictionary = {}
var original_process_paused = false
var dialogue_trigger:DialogueTrigger = null
var icon_src_map:Dictionary = {}
var action_manager
signal dialogue_closed

func _ready() -> void:
	load_dialogue()
	%next_btn.pressed.connect(_on_click_area_pressed)
	dialogue_panel.gui_input.connect(_on_panel_area_pressed)
	connect_option_buttons()
	process_mode = Node.PROCESS_MODE_ALWAYS
	action_manager = ActionManager.new()
	
func connect_option_buttons():
	for i in range(choosing_box.get_child_count()):
		var button = choosing_box.get_child(i)
		if button is Button:
			button.pressed.connect(_on_option_selected.bind(i,button))

func _on_option_selected(option_index,button:Button):
	var options = current_dialogue.options[option_index]
	var next_path_id:int = options.get("jump_to_msg_id",null)
	var action = options.get("action",null)
	
	if action is Dictionary:
		await action_manager.execute(action)
	
	current_dialogue_id = next_path_id
	_on_click_area_pressed()
	button.release_focus()
	
func load_dialogue():
	dialogue = Dialogue.new()
	id_map_dialogue = dialogue.get_dialogue_id_mapping(json_src_path)
	
	if id_map_dialogue.size() == 0:
		print("error happend in dialogues loading")
	else:
		var first_key = id_map_dialogue.keys()[0]
		show_dialogue_msg(id_map_dialogue[first_key].msg_id)
		
func _on_panel_area_pressed(event:InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if current_dialogue.options.size() < 2:
			_on_click_area_pressed()

func _on_click_area_pressed():
	if is_typing:
		stop_typing_animation()
		msg_content.visible_ratio = 1.0
	else:
		show_dialogue_msg(current_dialogue_id)

func load_option(option_list:Array):
	var existing_buttons: Array[Node] = choosing_box.get_children() as Array[Node]
	var option_count: int = option_list.size()
	
	var template_button: Button = existing_buttons[0] if not existing_buttons.is_empty() else Button.new()
	
	while existing_buttons.size() < option_count:
		var button: Button = template_button.duplicate()
		choosing_box.add_child(button)
		existing_buttons.append(button)	
		
	while existing_buttons.size() > option_count:
		var button: Button = existing_buttons.pop_back()
		button.queue_free()
		
	for i in range(option_count):
		var button: Button = existing_buttons[i]
		button.name = "option" + str(i)
		button.text = option_list[i].option_text
		
	if existing_buttons.is_empty() or existing_buttons[0] != template_button:
		template_button.free()
		
func show_dialogue_msg(current_dialogue_id:int):
	is_typing = true
	current_dialogue = id_map_dialogue[current_dialogue_id]
	%name.text = current_dialogue["name"]
	%text_content.text = current_dialogue["msg_content"]
	%character_icon.texture = icon_src_map.get_or_add(current_dialogue["icon_path"],load(current_dialogue["icon_path"]))
	%text_content.visible_ratio = 0
	var text_length = current_dialogue["msg_content"].length()
	var duration = max(0.5, text_length * 0.03)
	
	var dialogue_option_size = current_dialogue.options.size()
	if dialogue_option_size  == 0:
		option_box_enable= false
		get_tree().current_scene.remove_child(self)
		
		if dialogue_trigger and is_instance_valid(dialogue_trigger):
			dialogue_trigger.monitoring = true
			emit_signal("dialogue_closed")
			
		print("end dialogue")
		
	elif dialogue_option_size == 1:
		self.current_dialogue_id = current_dialogue.options[0]["jump_to_msg_id"]
		option_box_enable = false
	else: 
		option_box_enable = true
		load_option(current_dialogue.options)
	choosing_box.visible = option_box_enable

	tween = create_tween()
	tween.tween_property(
		msg_content, 
		"visible_ratio", 
		1.0, 
		duration
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	
	tween.finished.connect(_on_typing_finished)

func _on_typing_finished():
	is_typing = false
	tween = null

func pause_game():
	original_process_paused = true
	game_scene.set_process_mode(Node.PROCESS_MODE_DISABLED)
	
	if player:
		player.set_process_input(false)
		if player.has_method("freeze"):
			player.freeze() 
			
func resume_game():
	original_process_paused = false
	game_scene.set_process_mode(
		Node.PROCESS_MODE_DISABLED if original_process_paused else Node.PROCESS_MODE_INHERIT
	)

func set_dialogue_trigger(trigger:DialogueTrigger):
	dialogue_trigger = trigger

func stop_typing_animation():
	if tween:
		tween.kill()  
		tween = null
		is_typing = false
