class_name Item extends Node2D
var id:int
var item_name: String
var description: String
var item_weight: float
var value: int
var stackable: bool

#Just for testing
var resource = preload("res://icon.svg")
func _ready() -> void:
	#just for testing
	if randi() % 2 ==0:
		$TextureRect.texture = resource
		
