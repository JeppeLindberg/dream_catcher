extends Sprite2D

@onready var main = get_node('/root/main')

@export var move_direction = Vector2(0.5, 1)
@export var move_speed = 3.0
@export var cos_direction = Vector2(1, -0.5)
@export var cos_speed = 5.0
@export var cos_rotations_per_sec = 0.2
@export var sin_direction = Vector2(0, 1)
@export var sin_speed = 3.0
@export var sin_rotations_per_sec = 0.15

var lifetime = 0.0




func _process(delta: float) -> void:
	pass_time(delta)

func pass_time(delta: float) -> void:
	delta *= main.time_dialation
	
	lifetime += delta

	position = move_direction.normalized() * lifetime * move_speed + \
						cos_direction.normalized() * cos(deg_to_rad(lifetime * cos_rotations_per_sec * 360.0)) * cos_speed + \
						sin_direction.normalized() * sin(deg_to_rad(lifetime * sin_rotations_per_sec * 360.0)) * sin_speed

