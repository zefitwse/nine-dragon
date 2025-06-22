class_name DialogueTrigger extends Area2D
var area_active = false
@onready var chatting_tips_texture:TextureRect = $"../chatting_tips"


var is_dialogue_activa:bool

@export var json_src_path: String

func _ready() -> void:
	if not chatting_tips_texture:
		print("chatting_tips_texture not found")
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player and area_active == false:
		area_active = true
		chatting_tips_texture.visible = true
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player and area_active == true and is_dialogue_activa == false:
		area_active = false
		chatting_tips_texture.visible = false
		
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("e_pressed") and area_active == true and pause_status==false:
		#DialogueManager.show_dialogue_balloon_scene(preload("res://Scenes/dialogue_layout.tscn"),preload("res://dialogue/amelia_dialogue.dialogue"),"start")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("e_pressed") and area_active == true:
		DialogueManager.show_dialogue_balloon_scene(preload("res://Scenes/dialogue_layout.tscn"),preload("res://dialogue/amelia_dialogue.dialogue"),"start")

	
