extends KinematicBody2D

export var speed = 64
export var health = 3
var velocity = Vector2.ZERO
var move_direction = -1
var gravity = 1200
var hitted = false
var anim = "run"

onready var raycast = $ray_wall

func _ready():
	var playerSignal = get_tree().get_root().find_node("Player", true, false)
	playerSignal.connect("hitEnemy", self, "getHitted")
	
func _physics_process(delta: float) -> void:

	velocity.x = speed * move_direction
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)
	
	if move_direction == 1:
		$texture.flip_h = false
	else:
		$texture.flip_h = true
		
	if raycast.is_colliding():
		$anim.play("idle")

	_set_animation()

func _on_anim_animation_finished(anim_name: String) -> void:
	if anim_name == "idle":
		$texture.flip_h != $texture.flip_h
		raycast.scale.x *= -1
		move_direction *= -1
		$anim.play("run")

func _set_animation():
	anim = "run"
	if $ray_wall.is_colliding():
		anim = "idle"
	elif hitted:
		anim = "hit"		
	elif velocity.x != 0:
		anim = "run"
	
	if Input.is_action_pressed("hit"):
		velocity.x = 0
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func getHitted(body):
	get_tree().get_root().find_node(body.name)
	hitted = true
	print(body.name)
	print(body.health)
	$anim.play("hit")
	yield(get_tree().create_timer(0.2), "timeout")
	body.health -= 1
	hitted = false
	get_node("Hitbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	if health < 1:
		get_node("Hitbox/collision").set_deferred("disabled", true)
		body.queue_free()
		#health = 3
	get_node("Hitbox/collision").set_deferred("disabled", false)
	
	
