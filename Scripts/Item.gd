extends Area2D

export var fruits = 1

func _on_item_body_entered(_body) -> void:
	$anim.play("collected")
	Global.fruits += fruits

func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()


