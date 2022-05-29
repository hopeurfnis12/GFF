extends Node2D

const MIN_SPAWN_TIME = 3

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
	var viewRect := get_viewport_rect()
	var xPos := rand_range(viewRect.position.x, viewRect.end.x)
	var yPos := rand_range(viewRect.position.y, viewRect.end.y)
	var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
	var enemy: Enemy = enemyPreload.instance()
	
	if randf() <= 0.25: enemy.position = Vector2(xPos, 0) # print("top")
	elif randf() <= 0.5: enemy.position = Vector2(xPos, viewRect.end.y) # print("bottom")
	elif randf() <= 0.75: enemy.position = Vector2(0, yPos) # print("left")
	else: enemy.position = Vector2(viewRect.end.x, yPos) # print("right")
	
	get_tree().current_scene.add_child(enemy)
	if nextSpawnTime >= MIN_SPAWN_TIME: nextSpawnTime -= 0.5
	spawnTimer.start(nextSpawnTime) # restart the timer
