extends Node2D

@export var gun: Node2D
@export var bullet: PackedScene
@export var preview_bullet: PackedScene
@export var entities: Node2D
@export var preview: Node2D

var lifetime = 0.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		gun.look_at(event.position)

func _process(delta: float) -> void:
	lifetime += delta

	if Input.is_action_just_pressed("shoot"):
		var new_bullet = bullet.instantiate()
		entities.add_child(new_bullet)
		new_bullet.global_position = global_position
		new_bullet.direction = gun.global_transform.x
	
	for i in range(50):
		var new_preview_bullet = preview_bullet.instantiate()
		preview.add_child(new_preview_bullet)
		new_preview_bullet.global_position = global_position
		new_preview_bullet.direction = gun.global_transform.x
		new_preview_bullet.pass_time(float(i) + lifetime - floor(lifetime))
