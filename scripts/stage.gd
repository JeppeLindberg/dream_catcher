extends Node2D


func activate():
	for child in get_children():
		child.activate()

func deactivate():
	for child in get_children():
		child.deactivate()
