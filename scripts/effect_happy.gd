extends Node2D

var lifetime = 0.0

func _process(delta):
	lifetime += delta

	global_position += Vector2.UP * 5 * delta

	var alpha = 1.0-lifetime
	if alpha <= 0:
		queue_free()
	else:
		modulate = Color(modulate.r,modulate.g,modulate.b, alpha)


