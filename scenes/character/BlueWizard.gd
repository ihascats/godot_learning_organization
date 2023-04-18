extends KinematicBody2D

export var speed: int = 60

onready var fire_wand = $FireWand

var velocity = Vector2()

func get_input():
	
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	if Input.is_action_pressed("down"):
		velocity.y += speed
	
	if Input.is_action_just_pressed("click"):
		get_parent().new_projectile(
			get_local_mouse_position().normalized(), 
			position + fire_wand.position, 
			fire_wand.flip_v
			)

func _physics_process(delta):
	fire_wand.position = get_local_mouse_position().normalized() * 16
	fire_wand.look_at(get_global_mouse_position() + fire_wand.position)
	
	if fire_wand.position.x < 0:
		fire_wand.flip_v = true
	else:
		fire_wand.flip_v = false
	
	if fire_wand.position.y > 0:
		fire_wand.z_index = 10
	else:
		fire_wand.z_index = 0
		
	get_input()
	velocity = move_and_slide(velocity * 100 * delta, Vector2.UP)
	if velocity != Vector2.ZERO:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
