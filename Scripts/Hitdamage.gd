extends Area2D

func _ready():
	var directionSignal = get_tree().get_root().find_node("Player", true, false)
	directionSignal.connect("hitDirection", self, "colisionDirection")

func colisionDirection(direction):
	position.x = direction * 12
	
func _get_input():

	if _check_is_hitting():
		print("hitou")
		get_node("Hurtbox/collision").set_deferred("disabled", false)
	else:
		get_node("Hurtbox/collision").set_deferred("disabled", true)

func _check_is_hitting():
	if Input.is_action_pressed("hit"):
		return true
	return false
