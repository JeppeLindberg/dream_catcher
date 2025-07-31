extends StaticBody2D

@export var sprite: AnimatedSprite2D
@export var shape: CollisionShape2D


var spawn_delay = 0.0
var despawn_delay = 0.0


func _ready() -> void:
	shape.disabled = true
	visible = false
	sprite.animation = 'default'

func activate():
	spawn_delay = min((-global_position.x - global_position.y - 200.0) / 200.0, -0.01)

func deactivate():
	despawn_delay = min((-global_position.x - global_position.y - 200.0) / 200.0, -0.01)

func _process(delta: float) -> void:
	if spawn_delay < 0.0:
		spawn_delay += delta
		if spawn_delay > 0.0:
			spawn()
	
	if despawn_delay < 0.0:
		despawn_delay += delta
		if despawn_delay > 0.0:
			despawn()

func spawn():
	sprite.play('spawn')
	visible = true

func despawn():
	shape.disabled = true
	sprite.play('despawn')
	print(sprite.animation)

func _on_sprite_animation_finished() -> void:
	if sprite.animation == 'spawn':
		shape.disabled = false
		sprite.animation = 'default'

	if sprite.animation == 'despawn':
		visible = false
		sprite.animation = 'default'

