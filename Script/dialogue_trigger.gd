class_name DialogueTrigger extends Area2D
var area_active = false
const DIALOGUE_SCENE = preload("res://Scenes/dialogue.tscn")
var dialogue_instance = null
var is_dialogue_activa:bool
@export var json_src_path: String

func _ready() -> void:
	monitorable = true
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player and area_active == false:
		create_dialogue()
		area_active = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player and area_active == true and is_dialogue_activa == false:
		area_active = false

func create_dialogue():
	dialogue_instance = DIALOGUE_SCENE.instantiate()
	dialogue_instance.json_src_path = json_src_path
	get_tree().current_scene.add_child(dialogue_instance)
	
	if dialogue_instance.has_method("set_dialogue_trigger"):
		dialogue_instance.set_dialogue_trigger(self)
	
	if dialogue_instance.has_signal("dialogue_closed"):
		dialogue_instance.dialogue_closed.connect(_on_dialogue_closed)
		

	dialogue_instance.pause_game()
	is_dialogue_activa = true
	
func _on_dialogue_closed():
	if dialogue_instance:
		dialogue_instance.resume_game()
		dialogue_instance.queue_free()
		dialogue_instance = null
		is_dialogue_activa = false
