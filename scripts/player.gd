extends Node2D

@onready var main = get_node('/root/main')
@export var camera: Camera2D
@export var gun: Node2D
@export var effects: Node2D
@export var shoot_feedback: Node2D
@export var bullet: PackedScene
@export var preview_bullet: PackedScene
@export var happy_effect: PackedScene
@export var unhappy_effect: PackedScene
@onready var entities = get_node('/root/main/world/entities')
@onready var preview = get_node('/root/main/world/preview')
@export var debug: Control
@export var sleep_quality_decay_per_sec = 0.18
@export var good_sleep_window: Node2D


var next_shot_available = 0.0
var lifetime = 0.0
var sleep_quality_meter = 0.0
var sleep_quality_max = 1.0
var sleep_quality_min = -1.0
var good_sleep_achieved = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		gun.look_at(get_viewport().get_screen_transform()* get_viewport().get_canvas_transform().affine_inverse()* event.position)

func _process(delta: float) -> void:
	delta *= main.time_dialation

	lifetime += delta

	if sleep_quality_meter > 0.0:
		unhappy(abs(sleep_quality_meter - move_toward(sleep_quality_meter, 0, delta * sleep_quality_decay_per_sec)))
	
	debug.draw_text.append(sleep_quality_meter)

	if next_shot_available < lifetime and Input.is_action_just_pressed("shoot"):
		unhappy(0.3)
		var new_bullet = bullet.instantiate()
		entities.add_child(new_bullet)
		new_bullet.global_position = global_position
		new_bullet.direction = gun.global_transform.x
		shoot_feedback.move_direction(-gun.global_transform.x)
		next_shot_available = lifetime + 0.3
	
	for i in range(20):
		var new_preview_bullet = preview_bullet.instantiate()
		preview.add_child(new_preview_bullet)
		new_preview_bullet.global_position = global_position
		new_preview_bullet.direction = gun.global_transform.x
		new_preview_bullet.pass_time(float(i) + lifetime - floor(lifetime))

func happy():
	sleep_quality_meter += 2.0
	if sleep_quality_meter > sleep_quality_max:
		var new_happy_effect = happy_effect.instantiate()
		effects.add_child(new_happy_effect)
		new_happy_effect.global_position = global_position
		sleep_quality_max = sleep_quality_meter + 1.0
		sleep_quality_min = sleep_quality_meter - 1.0
		
		if (sleep_quality_meter > 15.0) and (not good_sleep_achieved):
			good_sleep_achieved = true
			good_sleep_window.visible = true

func unhappy(amount):
	sleep_quality_meter -= amount
	if sleep_quality_meter < sleep_quality_min:
		var new_unhappy_effect = unhappy_effect.instantiate()
		effects.add_child(new_unhappy_effect)
		new_unhappy_effect.global_position = global_position
		sleep_quality_max = sleep_quality_meter + 1.0
		sleep_quality_min = sleep_quality_meter - 1.0
