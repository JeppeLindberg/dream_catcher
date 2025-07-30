extends Node2D

@export var entities: Node2D
@export var spawns_per_sec = 2.0
@export var spawn_prefab: PackedScene
@export var max_distance = 10.0

var spawn_progress = 0.0

func _ready() -> void:
	spawn_progress += 1.0/spawns_per_sec

func _process(delta: float) -> void:
	spawn_progress += delta
	if spawn_progress > 1.0/spawns_per_sec:
		var new_spawn = spawn_prefab.instantiate()
		entities.add_child(new_spawn)
		new_spawn.global_position = global_position + Vector2.UP.rotated(deg_to_rad(randf()* 360.0)) * max_distance * randf()
		spawn_progress -= 1.0/spawns_per_sec


