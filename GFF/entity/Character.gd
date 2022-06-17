extends KinematicBody2D
class_name Character, "res://assets/v1.1 dungeon crawler 16x16 pixel pack/heroes/knight/knight_idle_anim_f0.png"

const FRICTION: float = 0.15

export(int) var hp: int = 2 setget set_hp
signal hp_changed(new_hp)

export(int) var accerelation: int = 15
export(int) var max_speed: int = 25

onready var state_machine: Node = get_node("FiniteStateMachine")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

var mov_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

onready var invincible_timer = $InvincibleTimer


func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * accerelation


func take_damage(dmg: int, dir: Vector2, force: int) -> void:
	if invincible_timer.is_stopped():
		invincible_timer.start()
		self.hp -= dmg
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
		else: 
			state_machine.set_state(state_machine.states.dead)
			velocity += dir * force * 2


func set_hp(new_hp: int) -> void:
	hp = new_hp
	emit_signal("hp_changed", new_hp)
