extends Light2D

onready var light_animation: AnimationPlayer = get_node("AnimationLamp")

func _ready():
	light_animation.play("Light")
