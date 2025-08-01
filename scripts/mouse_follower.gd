extends Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		global_position = get_viewport().get_screen_transform()* get_viewport().get_canvas_transform().affine_inverse() * event.position
