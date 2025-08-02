extends Node2D

@onready var main = get_node('/root/main')
@export var stages: Array[Node2D]
@export var secs_between_stages = 10.0

var next_stage_timer = 0.0
var stage_queue = []
var current_stage = -1


func _ready() -> void:
	stage_queue = [0]
	next_stage_timer = 1.0
	for stage in stages:
		stage.visible = true;


func _process(delta: float) -> void:
	delta *= main.time_dialation

	next_stage_timer += delta * 1.0/secs_between_stages
	if next_stage_timer > 1.0:
		var prev_stage = current_stage
		current_stage = stage_queue.pop_front()

		if prev_stage != -1:
			stages[prev_stage].deactivate()
		stages[current_stage].activate()

		if len(stage_queue) == 0:
			stage_queue = range(len(stages))
			stage_queue.erase(current_stage)
			stage_queue.shuffle()

		next_stage_timer -= 1.0
