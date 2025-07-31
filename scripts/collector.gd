extends Node2D



@export var collect_prefab: PackedScene



func collect(nodes = []):
	var new_collect = collect_prefab.instantiate()
	add_child(new_collect)
	new_collect.global_position = global_position

	for node in nodes:
		node.start_collecting()
		node.call_deferred('reparent', new_collect)


