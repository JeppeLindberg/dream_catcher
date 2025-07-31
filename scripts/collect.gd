extends Node2D


@export var curve_toward_center: Curve
@export var secs_to_get_to_center = 0.5
@export var random_direction_speed = 200.0

var lifetime = 0.0
@onready var random_direction = Vector2.UP.rotated(deg_to_rad(randf() * 360.0))

var child_base_pos = {}


func initiate() -> void:
	for child in get_children():
		child_base_pos[child] = child.position

func _process(delta: float) -> void:
	if len(child_base_pos) == 0:
		initiate()
	if len(child_base_pos) == 0:
		return

	lifetime += delta

	for child in get_children():
		var base_pos = child_base_pos.get(child)
		if (base_pos != null) and (lifetime < secs_to_get_to_center):
			child.position = (base_pos + random_direction * random_direction_speed * lifetime) * curve_toward_center.sample(lifetime * 1/secs_to_get_to_center)
		else:
			child.position = Vector2.ZERO
				
	if lifetime > secs_to_get_to_center:
		for child in get_children():
			if child.has_method('collect'):
				child.collect()
		queue_free()
