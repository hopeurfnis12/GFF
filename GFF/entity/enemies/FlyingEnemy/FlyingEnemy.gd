extends Enemy

onready var hitbox: Area2D = get_node("Hitbox")

var can_attack: bool = true
var distance_to_player: float


func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player) and player.visible == true:
		distance_to_player = (player.position - global_position).length()
		_get_path_to_player()
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO


func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
