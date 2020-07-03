extends Navigation2D

onready var parent = get_parent()

func _ready():
	var initial_nav_point = get_closest_point(parent.position)
	print(initial_nav_point)
	lerp(parent.position, initial_nav_point, 2)
