# 外部场景角色脚本（main_scene.gd）
extends Node2D

func _on_door_entered(body: Node2D):
	print('sssssssw')
	if body.name == "Player":
		# 触发场景切换
		SceneManager.transition_to("res://Scenes/InnerScene.tscn")  #:ml-citation{ref="1" data="citationList"}
 
