extends Enemy

const THROWABLE_KNIFE_SCENE: PackedScene = preload("res://entity/enemies/Goblin/ThrowableKnife.tscn")

const MAX_DISTANCE_TO_PLAYER: int = 100

var can_attack: bool = true
var distance_to_player: float

onready var attack_timer = $AttackTimer


func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player) and player.visible == true:
		distance_to_player = (player.position - global_position).length()
		if distance_to_player > MAX_DISTANCE_TO_PLAYER:
			_get_path_to_player()
		else:
			if can_attack and state_machine.state == state_machine.states.idle:
				can_attack = false
				_throw_knife()
				attack_timer.start()
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO


func _throw_knife() -> void:
	var projectile: Area2D = THROWABLE_KNIFE_SCENE.instance()
	get_tree().current_scene.add_child(projectile)
	var projectile_animation = projectile.get_node("AnimationPlayer")
	projectile_animation.play("launch")
	projectile.launch(global_position, (player.position -
	global_position).normalized(), 150)


func _on_AttackTimer_timeout() -> void:
	can_attack = true
