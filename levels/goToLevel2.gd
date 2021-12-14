extends Area2D

func _on_levelChanger_body_entered(_body):
	if Global.fruits >= 3:
		get_tree().change_scene("res://levels/nivel_02.tscn")
		Global.fruits = 0
