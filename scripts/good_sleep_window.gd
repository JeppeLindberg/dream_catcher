extends Node2D


@onready var main = get_node('/root/main')


func _process(_delta: float) -> void:
	if visible:
		main.time_dialation = 0.0
	else:
		main.time_dialation = 1.0

func continue_pressed():
	visible = false
