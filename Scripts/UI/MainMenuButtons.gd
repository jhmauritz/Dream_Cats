extends Node

onready var options_menu = preload("res://Scenes/UIandUX/Options_Popup.tscn")

func _on_PlayButton_pressed():
	SceneTransition.change_scene("res://Scenes/Levels/TutorialLevel.tscn")


func _on_OptionButton_pressed():
	pass
