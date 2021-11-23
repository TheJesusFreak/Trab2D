extends KinematicBody2D

export var speed = 64
export var healt = 1
var velocity = Vector2.ZERO
var move_direction = -1

onready var raycast = $ray_wall

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	
	velocity = move_and_slide(velocity)
	
	if move_direction == 1:
		$texture.flip_h = false
	else:
		$texture.flip_h = true
		
	if raycast.is_colliding():
		$anim.play("idle")


func _on_anim_animation_finished(anim_name):
	if anim_name == "idle":
		$texture.flip_h != $texture.flip_h
		raycast.scale.x *= -1
		move_direction *= -1
		$anim.play("run")
