extends Area2D
class_name Hitbox

export(int) var damage: int = 1
export(int) var knockback_force: int = 150
var knockback_direction: Vector2 = Vector2.ZERO
var inBody = false

onready var collision_shape: CollisionShape2D = get_child(0)
onready var timer: Timer = Timer.new()


func _init() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")
	__ = connect("body_exited", self, "_on_body_exited")


func _ready() -> void:
	assert(collision_shape != null)
	timer.wait_time = 0.5
	add_child(timer)


func _on_body_exited(body: PhysicsBody2D) -> void:
	inBody = false
	timer.stop()
	
	
func _on_body_entered(body: PhysicsBody2D) -> void:
	inBody = true
	timer.start()
	while inBody:
		_collide(body)
		yield(timer, "timeout")


func _collide(body: KinematicBody2D) -> void:
	if body == null or not body.has_method("take_damage"): queue_free()
	else:
		body.take_damage(damage, knockback_direction, knockback_force)
