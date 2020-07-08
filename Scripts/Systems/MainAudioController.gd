extends Node2D

var master_volume_bus = AudioServer.get_bus_index("Master")
var Master_vol = 2000

func _on_fullvol_pressed():
	$fullvol.visible = false
	$halfvol.visible = true
	AudioServer.set_bus_volume_db(master_volume_bus, -5)


func _on_halfvol_pressed():
	$halfvol.visible = false
	$novol.visible = true
	AudioServer.set_bus_volume_db(master_volume_bus, -INF)


func _on_novol_pressed():
	$novol.visible = false
	$fullvol.visible = true
	AudioServer.set_bus_volume_db(master_volume_bus, -0)
