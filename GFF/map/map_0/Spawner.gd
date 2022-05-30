extends Node2D

const MIN_SPAWN_TIME = 2

var preloadedEnemies := [
	preload("res://entity/enemies/FlyingEnemy/FlyingEnemy.tscn"),
	preload("res://entity/enemies/Goblin/Goblin.tscn")
]

onready var spawnTimer := $SpawnTimer
var nextSpawnTime := 5.0

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)

func _on_SpawnTimer_timeout():
	var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
	var enemy: Enemy = enemyPreload.instance()
	
	if randf() <= 0.2: enemy.position = $Sprite1.global_position
	elif randf() <= 0.4: enemy.position = $Sprite2.global_position
	elif randf() <= 0.6: enemy.position = $Sprite3.global_position
	elif randf() <= 0.8: enemy.position = $Sprite4.global_position
	else: enemy.position = $Sprite5.global_position
	enemy.position.y += 10
	
	get_tree().current_scene.add_child(enemy)
	if nextSpawnTime >= MIN_SPAWN_TIME: nextSpawnTime -= 0.5
	spawnTimer.start(nextSpawnTime) # restart the timer
