extends CharacterBody2D

@export var move_speed = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

enum Direction { DOWN, LEFT, RIGHT, UP }
var last_direction: Direction = Direction.DOWN  # 默认面朝下方
var is_moving: bool = false

func update_animation(input_vector: Vector2):
	is_moving = input_vector != Vector2.ZERO
	if is_moving:
		# 根据输入方向决定动画方向
		if abs(input_vector.x) > abs(input_vector.y):
			# 水平方向优先
			if input_vector.x > 0:
				last_direction = Direction.RIGHT
				animated_sprite.play("move_right")
			else:
				last_direction = Direction.LEFT
				animated_sprite.play("move_left")
		else:
			# 垂直方向优先
			if input_vector.y > 0:
				last_direction = Direction.DOWN
				animated_sprite.play("move_down")
			else:
				last_direction = Direction.UP
				animated_sprite.play("move_up")
	else:
		# 播放对应方向的idle动画
		match last_direction:
			Direction.DOWN:
				animated_sprite.play("idle_down")
			Direction.UP:
				animated_sprite.play("idle_up")
			Direction.LEFT:
				animated_sprite.play("idle_left")
			Direction.RIGHT:
				animated_sprite.play("idle_right")

func _physics_process(_delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * move_speed
	# 更新动画状态
	update_animation(input_vector)
	move_and_slide()
