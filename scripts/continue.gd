extends Area2D


@onready var main = get_node('/root/main')
@export var collider : CollisionShape2D


func _input(event):
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT) and (not event.pressed):
			if main.is_pos_overlapping_collider(collider, get_viewport().get_screen_transform() * get_viewport().get_canvas_transform().affine_inverse() * event.position * 0.5):
				get_parent().continue_pressed()

