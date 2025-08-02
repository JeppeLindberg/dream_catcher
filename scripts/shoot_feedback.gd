extends Node2D

@export var impact_magnitude = 500.0
@export var impact_duration = 0.01
@export var move_back_speed = 20.0

var directions = []
var times = []

var lifetime = 0.0

func _process(delta: float) -> void:
	lifetime += delta
	for direction in directions:
		global_position += direction.normalized() * impact_magnitude * delta
	for i in range(len(times) -1, -1, -1):
		if times[i]+impact_duration < lifetime:
			times.remove_at(i)
			directions.remove_at(i)
	
	global_position = global_position.move_toward(Vector2.ZERO,move_back_speed*delta)

func move_direction(direction):
	directions.append(direction.normalized() + Vector2.UP.rotated(deg_to_rad(randf() * 360.0)) * 0.5)
	times.append(lifetime)
