extends Node2D

var lifetime = 0.0

@onready var main = get_node('/root/main')
@export var direction = Vector2.UP

func _process(delta):
	delta *= main.time_dialation

	lifetime += delta

	global_position += direction * 5 * delta

	var alpha = 1.0-(lifetime * 0.5)
	if alpha <= 0:
		queue_free()
	else:
		modulate = Color(modulate.r,modulate.g,modulate.b, alpha)


