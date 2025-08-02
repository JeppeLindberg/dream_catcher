extends Camera2D

@onready var main = get_node('/root/main')
@export var mouse_follower:Node2D
@export var shoot_feedback: Node2D


func _process(_delta: float) -> void:
	global_position = ((mouse_follower.global_position * 0.5) + (shoot_feedback.global_position * 9.5)) / 15.0


