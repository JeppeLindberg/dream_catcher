extends Area2D

@export var direction = Vector2.ZERO
@export var speed = 30.0
@export var up_down_magnitude = 20.0
@export var up_down_speed = 1.0
@export var poof_prefab: PackedScene
@export var visual: Node2D
@export var poofs_per_second = 1.5
@export var color_sequence: Array[Color]

@onready var main = get_node('/root/main')
@onready var player = get_node('/root/main/world/entities/player')

var lifetime = 0.0
var collecting = false
var poof_timer = 0.0
var color_sequence_i = 0



func _ready() -> void:
	add_to_group('dream')
	poof_timer = 1.0
	color_sequence_i = randi_range(0, len(color_sequence) -1)

func _process(delta: float) -> void:
	if collecting:
		return

	delta *= main.time_dialation

	poof_timer += delta * poofs_per_second
	lifetime += delta
	global_position += (direction * speed * delta) + (Vector2.UP * cos(lifetime * up_down_speed) * up_down_magnitude * delta)
	if poof_timer > 1.0:
		var new_poof = poof_prefab.instantiate()
		visual.add_child(new_poof)
		new_poof.self_modulate = color_sequence[color_sequence_i]
		poof_timer -= 1.0
		color_sequence_i += 1
		if color_sequence_i >= len(color_sequence):
			color_sequence_i = 0

func collect():
	player.happy()

func start_collecting():
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred('disabled', true)

	collecting = true
