extends Node2D

const FILE_NAME = "user://sound_data.save"

var save_dict = {
		"filename": get_filename(),
		"master_vol": Master_vol
	}

var master_volume_bus = AudioServer.get_bus_index("Master")
var Master_vol = null

func _ready():
	load_data()
	if Master_vol == 0:
		$fullvol.visible = true
		$halfvol.visible = false
		$novol.visible = false
	
	elif Master_vol == 1:
		$fullvol.visible = false
		$halfvol.visible = true
		$novol.visible = false
	
	elif Master_vol == 2:
		$fullvol.visible = false
		$halfvol.visible = false
		$novol.visible = true

func _process(delta):
	print(Master_vol)

func _on_fullvol_pressed():
	$fullvol.visible = false
	$halfvol.visible = true
	AudioServer.set_bus_volume_db(master_volume_bus, -5)
	Master_vol = 1
	save()


func _on_halfvol_pressed():
	$halfvol.visible = false
	$novol.visible = true
	AudioServer.set_bus_volume_db(master_volume_bus, -INF)
	Master_vol = 2
	save()


func _on_novol_pressed():
	$novol.visible = false
	$fullvol.visible = true
	AudioServer.set_bus_volume_db(master_volume_bus, -0)
	Master_vol = 0
	save()

func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_var(Master_vol)
	file.close()

func load_data():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		Master_vol = file.get_var()
		file.close()
	else:
		Master_vol = 0



































