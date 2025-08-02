extends AnimatedSprite2D

@onready var main = get_node('/root/main')


func _ready() -> void:
	rotation_degrees = [0.0, 90.0, 180.0, 270.0].pick_random()

func _process(_delta: float) -> void:
	speed_scale = main.time_dialation


func _on_animation_finished() -> void:
	queue_free()
