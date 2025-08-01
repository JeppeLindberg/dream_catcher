extends Node2D


var time_dialation = 1.0

@export var music: AudioStream
@onready var audio = get_node('/root/main/audio')


func _ready() -> void:
	audio.play_music(music)


func is_pos_overlapping_collider(collider, pos):	
	var point = PhysicsPointQueryParameters2D.new()
	point.position = pos
	point.collide_with_areas = true;

	var collision = collider.get_world_2d().direct_space_state.intersect_point(point);
	for col in collision:
		if collider.get_parent() == col['collider']:
			return(true)
	return(false)

