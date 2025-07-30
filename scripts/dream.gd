extends Area2D

@export var direction = Vector2.ZERO
@export var speed = 30.0
@export var up_down_magnitude = 20.0
@export var up_down_speed = 1.0

var time_elapsed = 0.0


func _ready() -> void:
	add_to_group('dream')

func _process(delta: float) -> void:
	time_elapsed += delta
	global_position += (direction * speed * delta) + (Vector2.UP * cos(time_elapsed * up_down_speed) * up_down_magnitude * delta)
