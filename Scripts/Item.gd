extends Area2D

func _on_item_body_entered(body) -> void:
	print(body.name)
	$anim.play("collected")


func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()
