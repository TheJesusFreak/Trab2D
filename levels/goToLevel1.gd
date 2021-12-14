extends Area2D

func _on_levelChanger_body_entered(body):
	get_tree().change_scene("res://levels/level_01.tscn")
