extends CanvasLayer

signal scene_changer()

onready var anim_player = $AnimationPlayer
onready var black = $Control/ColorRect

func change_scene(path, delay = 0.5):
	print("bitch")
	yield(get_tree().create_timer(delay), "timeout")
	anim_player.play("fade")
	yield(anim_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	anim_player.play_backwards("fade")

