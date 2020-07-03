extends KinematicBody2D

onready var health = max_health setget _set_health

export (float) var max_health = 100

func kill():
	queue_free()

func _set_health(value):
	var prev_health = health
	health = clamp (value, 0, max_health)
	if health != prev_health:
		if health == 0:
			kill()

func enemy_damage(amount):
		_set_health(health - amount)
		get_node("EnemyHealthBar")._on_health_update(health, 3)


func _on_DamageTrigger_body_entered(body: Node) -> void:
	if body.has_method("damage"):
		body.damage(10)
