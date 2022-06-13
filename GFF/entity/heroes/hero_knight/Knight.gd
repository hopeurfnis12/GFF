extends Character

onready var sword: Node2D = get_node("Sword")
onready var sword_hitbox: Area2D = get_node("Sword/Node2D/SwordSprite/Hitbox")
onready var sword_animation: AnimationPlayer = sword.get_node("AnimationSword")

onready var attack_timer = $AttackTimer
var first_attack = false

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true

	sword.rotation = mouse_direction.angle()
	sword_hitbox.knockback_direction = mouse_direction
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1


func get_input() -> void:
	if self.visible == true:
		mov_direction = Vector2.ZERO
		if Input.is_action_pressed("ui_down"):
			mov_direction += Vector2.DOWN
		if Input.is_action_pressed("ui_left"):
			mov_direction += Vector2.LEFT
		if Input.is_action_pressed("ui_right"):
			mov_direction += Vector2.RIGHT
		if Input.is_action_pressed("ui_up"):
			mov_direction += Vector2.UP
		
		if Input.is_action_just_pressed("ui_attack"):
			if attack_timer.is_stopped():
				if !first_attack:
					first_attack = true
					sword_animation.play("attack")
				else:
					first_attack = false
					sword_animation.play("attack2")
				attack_timer.start()
	else: mov_direction = Vector2.ZERO


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		first_attack = false
