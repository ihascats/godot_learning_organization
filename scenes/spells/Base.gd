extends RigidBody2D

export(Resource) var spell_data

onready var animated_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D

var direction = Vector2.RIGHT
var flip_v = false

func _ready():
	randomize()
	var dir = Directory.new()
	if dir.open("res://scenes/spells/resources/") == OK:
		
		dir.list_dir_begin(true)
		
		var file_name = dir.get_next()
		var file_list = []
		
		while file_name != "":
			if file_name.ends_with('.tres'):
				file_list.push_front(file_name)
			file_name = dir.get_next()
			
		var path = str("res://scenes/spells/resources/" + file_list[randi()%file_list.size()])
		spell_data = load(path)
	
	else:
		print("An error occurred when trying to access the path.")
	
	animated_sprite.frames = spell_data.frames
	animated_sprite.play("default")
	collision_shape.shape.radius = spell_data.collision_radius
	fire()
	
func fire():
	linear_velocity = direction * spell_data.speed / 2
	animated_sprite.flip_v = flip_v
	
func _process(_delta):
	# Rotate the projectile to face the direction of its velocity.
	rotation = linear_velocity.normalized().angle()

