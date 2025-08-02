extends Node2D

@onready var main = get_node('/root/main')

@export var background_prefab: PackedScene
@export var spawns_per_sec = 0.06


var spawns_lifetime = 0.0



func _ready() -> void:	
	for i in range(20):
		var new_background_prefab = background_prefab.instantiate()
		add_child(new_background_prefab)
		new_background_prefab.global_position = global_position
		new_background_prefab.pass_time(float(i) * 1/spawns_per_sec)


func _process(delta: float) -> void:
	delta *= main.time_dialation

	spawns_lifetime += delta * spawns_per_sec
	if spawns_lifetime > 1.0:
		var new_background_prefab = background_prefab.instantiate()
		add_child(new_background_prefab)
		new_background_prefab.global_position = global_position
		spawns_lifetime -= 1.0
		new_background_prefab.pass_time(spawns_lifetime)
