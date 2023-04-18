extends Node
export var spells: PackedScene

func new_projectile(direction: Vector2, position: Vector2, flip_v: bool):
	var new_spell = spells.instance()
	new_spell.direction = direction
	new_spell.position = position
	new_spell.flip_v = flip_v
	add_child(new_spell)
