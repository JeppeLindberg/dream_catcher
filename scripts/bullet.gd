extends Node2D

var direction = Vector2.ZERO

@export_flags_2d_physics var wall_layer
@export var speed: float
@export var shape: CollisionShape2D
@export var preview = false
@export var preview_lifetime = 50.0

@onready var debug = get_node('/root/main/canvas_layer/debug')
@onready var collector = get_node('/root/main/world/entities/player/collector')

var lifetime = 0.0
var collecting = false


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if collecting:
		return

	if preview:
		queue_free()
		return

	pass_time(delta)

var pending_warp = Vector2.ZERO

func pass_time(delta: float):
	lifetime += delta
	if preview:
		modulate = Color(modulate.r,modulate.g, modulate.b, inverse_lerp(preview_lifetime, 0.0, lifetime))

	var remaining_distance = speed * delta
	if preview:
		remaining_distance *= 0.2

	for i in range(100):
		var pos_from = global_position
		var pos_to = global_position + direction.normalized() * remaining_distance
		global_position = get_next_pos(pos_from, pos_to)
		# debug.draw_lines.append( [pos_from, global_position])
		remaining_distance -= pos_from.distance_to(global_position)

		if pending_warp != Vector2.ZERO:
			global_position += pending_warp
		pending_warp = Vector2.ZERO

		if remaining_distance <= 0.0:
			break

func get_next_pos(pos_from, pos_to):
	var space_state = get_world_2d().direct_space_state
	var ray = PhysicsRayQueryParameters2D.new()
	ray.from = lerp(pos_from, pos_to, 0.001)
	ray.to = pos_to
	ray.hit_from_inside = false
	ray.collision_mask = wall_layer
	ray.collide_with_areas = true
	var collision = space_state.intersect_ray(ray)

	if collision.has('collider'):
		if collision['normal'] == Vector2.ZERO:
			queue_free()
			visible = false
			return pos_to

		if collision['collider'].is_in_group('border'):
			pending_warp = collision['collider'].warp_delta
			return collision['position']
		else:
			direction = (pos_to-pos_from).bounce(collision['normal']).normalized()			
			return collision['position']
	
	return pos_to

func _on_area_entered(area:Area2D) -> void:
	if collecting:
		return

	if preview:
		return
	
	if area.is_in_group('dream'):
		collector.collect([self, area])

func start_collecting():
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred('disabled', true)
	collecting = true
