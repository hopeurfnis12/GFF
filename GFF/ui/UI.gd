extends CanvasLayer

const MIN_HEALTH: int = 0

var max_hp: int = 4

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var health_bar: TextureProgress = get_node("Interface/HealthBar")
onready var health_bar_tween: Tween = get_node("Interface/HealthBar/Tween")
onready var pause: Control = get_node("Pause")

func _ready() -> void:
	$Pause.visible = false
	$Result.visible = false
	max_hp = player.hp
	_update_health_bar(100)

func _update_health_bar(new_value: int) -> void:
	var __ = health_bar_tween.interpolate_property(health_bar, "value", health_bar.value,
	new_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	
	__ = health_bar_tween.start()
	
func _on_Player_hp_changed(new_hp: int):
	var new_health: int = int((100 - MIN_HEALTH) * float(new_hp) / max_hp) + MIN_HEALTH
	_update_health_bar(new_health)


func _on_Player_hide():
	$Pause.can_toggle_pause = false
	$Result.visible = true
