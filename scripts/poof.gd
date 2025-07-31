extends AnimatedSprite2D


func _ready() -> void:
	rotation_degrees = [0.0, 90.0, 180.0, 270.0].pick_random()


func _on_animation_finished() -> void:
	queue_free()
