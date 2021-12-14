extends Area2D

func _on_fallzone_body_entered(_body):
	Global.fruits = 0
	get_tree().reload_current_scene()
