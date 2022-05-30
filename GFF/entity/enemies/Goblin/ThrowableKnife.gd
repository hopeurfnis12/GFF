extends Hitbox


onready var bullet_animation: AnimationPlayer = get_node("AnimationPlayer")
var enemy_exited: bool = false

var direction: Vector2 = Vector2.ZERO
var knife_speed: int = 0
var hit: bool = false


func launch(initial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = initial_position
	direction = dir
	knockback_direction = dir
	knife_speed = speed
	
	rotation += dir.angle()


func _physics_process(delta: float) -> void:
	if hit: 
		if !bullet_animation.is_playing():
			queue_free()
	else: position += direction * knife_speed * delta
	


func _on_ThrowableKnife_body_exited(body: KinematicBody) -> void:
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)
		set_collision_mask_bit(2, true)
		set_collision_mask_bit(3, true)


func _collide(body: KinematicBody2D) -> void:
	if enemy_exited:
		hit = true
		bullet_animation.play("hit")
		if body != null:
			body.take_damage(damage, knockback_direction, knockback_force)


func _on_ThrowableKnife_area_exited(area):
	hit = true
	bullet_animation.play("hit")
