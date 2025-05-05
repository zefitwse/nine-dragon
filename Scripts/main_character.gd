class_name Player extends CharacterBody2D
@export var speed = 4000
@onready var animated_obj = $AnimatedSprite2D
const IDLE_THRESHOLD = 10.0
var idle_time = 0.0
func get_input(delta):
	var input_direction = Input.get_vector("main_character_left","main_character_right","main_character_up","main_character_down")
	
	velocity = input_direction.normalized() * speed * delta
	
	if Vector2.ZERO == input_direction:
		idle_time += delta
		if(IDLE_THRESHOLD<=idle_time):
			animated_obj.play("idle")
	else:
		idle_time = 0.0
	
	# Priority of animation playing
	if(input_direction.y == 0):
		if(input_direction.x < 0):
			animated_obj.play("run_left")
		elif(input_direction.x > 0):
			animated_obj.play("run_right")
		
	if(input_direction.y < 0):
		animated_obj.play("run_up")
	elif(input_direction.y > 0):
		animated_obj.play("run_down")
		
	if(input_direction.x == 0 and input_direction.y == 0 and idle_time<=IDLE_THRESHOLD):
		animated_obj.stop()
		
func position_update(position):
	global_position = position
		
	
func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide()
