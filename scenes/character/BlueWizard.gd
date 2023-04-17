extends KinematicBody2D

export (int) var speed = 100 
export (PackedScene) var spells 

onready var fire_wand = $FireWand

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_just_pressed("click"):
		var new_spell = spells.instance()
		new_spell.direction = get_local_mouse_position().normalized()
		new_spell.position = fire_wand.position
		new_spell.flip_v = fire_wand.flip_v
		add_child(new_spell)
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	
	fire_wand.position = get_local_mouse_position().normalized() * 16
	fire_wand.look_at(get_global_mouse_position())
	if fire_wand.position.x < 0:
		fire_wand.flip_v = true
	else:
		fire_wand.flip_v = false
	
	if fire_wand.position.y > 0:
		fire_wand.z_index = 10
	else:
		fire_wand.z_index = 0
		
	get_input()
	velocity = move_and_slide(velocity)
	if velocity != Vector2.ZERO:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
