extends StaticBody2D


@export var warp_delta = Vector2.ZERO


func _ready() -> void:
	add_to_group('border')
