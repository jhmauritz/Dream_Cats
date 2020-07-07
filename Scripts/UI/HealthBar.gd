extends TextureProgress

signal pulse()

const FLASH_RATE = 0.05
const N_FLASH = 4

onready var health_bar = self
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween
onready var pulse_tween = $PulseTween
onready var flash_tween = $FlashTween

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red
export (Color) var pulse_color = Color.darkred
export (Color) var flash_color = Color.orangered
export (float, 0, 1, 0.05) var caution_zone = 0.5
export (float, 0, 1, 0.05) var danger_zone = 0.2
export (bool) var is_pulse = false

func _on_health_update(health, amount):
	health_bar.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()
	
	_assign_color(health)
	if amount < 0:
		_flash_damage()

func _on_max_health_updated(max_health):
	health_bar.max_value = max_health
	health_under.max_value = max_health

func _flash_damage():
	for i in range(N_FLASH * 2):
		var color = health_bar.tint_progress if i % 2 == 1 else flash_color
		var time = FLASH_RATE * i + FLASH_RATE
		flash_tween.interpolate_callback(health_bar, time, "set", "tint_progress", color)
		flash_tween.start()

func _assign_color(health):
	if health == 0:
		pulse_tween.set_active(false)
	elif health < health_bar.max_value * danger_zone:
		if is_pulse:
			if !pulse_tween.is_active():
				pulse_tween.interpolate_property(health_bar, "tint_progress", pulse_color, danger_color, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				pulse_tween.interpolate_callback(self, 0.0, "emit_signal", "pulse")
				pulse_tween.start()
		else:
			health_bar.tint_progress = danger_color
	else:
		pulse_tween.set_active(false)
		if health < health_bar.max_value * caution_zone:
			health_bar.tint_progress = caution_color
		else: 
			health_bar.tint_progress = healthy_color
