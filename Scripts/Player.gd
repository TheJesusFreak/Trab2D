extends KinematicBody2D

var velocity = Vector2.ZERO
var health = 3
var collectedItems = 0
var move_speed = 480
var gravity = 1200
var jump_force = -800
var is_grounded
var is_hitting
var hurted = false
var knockback_dir = 1
var knockback_int = 500

signal hitEnemy(body)
signal hitDirection(direction)

onready var raycasts = $raycasts

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	_get_input()
	
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_ground()
	
	is_hitting = _check_is_hitting()
	
	_set_animation()
	
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if  is_grounded && is_hitting:
		velocity.x = lerp(velocity.x, (move_speed / 3) * move_direction, 0.2)
	elif !is_grounded:
		velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	elif is_grounded && !is_hitting:
		velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
		
	if move_direction != 0:
		$texture.scale.x = move_direction
		knockback_dir = move_direction 
		emit_signal("hitDirection", move_direction)
			
	if !is_hitting:
		get_node("Hitdamage/collision").set_deferred("disabled", true)
	else: 
		if is_hitting:
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("Hitdamage/collision").set_deferred("disabled", false)
			yield(get_tree().create_timer(0.2), "timeout")
			get_node("Hitdamage/collision").set_deferred("disabled", true)
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_force / 2

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	
	return false
	
func _check_is_hitting():
	if Input.is_action_pressed("hit"):
		return true
	return false
	
func _set_animation():
	var anim = "idle"
	
	if !is_grounded:
		anim = "jump"
	elif velocity.x != 0:
		anim = "run"
	
	if velocity.y > 0 and !is_grounded:
		anim = "fall"
	
	if Input.is_action_pressed("hit"):
		velocity.x = 0
		anim = "hit"
		
	if hurted:
		anim = "hurt"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	velocity.x = -knockback_dir * knockback_int
	velocity = move_and_slide(velocity)

func _on_Hurtbox_body_entered(body):
	hurted = true
	health -= 1
	knockback()
	get_node("Hurtbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("Hurtbox/collision").set_deferred("disabled", false)
	hurted = false
	if health < 1:
		Global.fruits = 0
		queue_free()
		get_tree().reload_current_scene() 

func _on_Hitdamage_body_entered(body):
	emit_signal("hitEnemy", body)
	
