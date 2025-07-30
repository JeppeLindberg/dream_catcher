extends Control


var draw_lines = []



func _process(_delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	for line in draw_lines:
		draw_line(line[0], line[1], Color.WHITE_SMOKE)
	
	draw_lines = []
	

