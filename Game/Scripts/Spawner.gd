extends Node3D

var spawnPoints : Array[Node]
var enemyNodes : Array[Node]
var hasSpawned : bool
var levelIsfinished : bool

@onready var gate: Node3D 


func _ready() -> void:
	spawnPoints = get_node("SpawnPoints").get_children()
	gate = $Gate

func _process(delta: float) -> void:
	if enemyNodes.is_empty() or levelIsfinished:
		return
	
	for enemy in enemyNodes:
		if enemy != null:
			return
	
	levelIsfinished = true
	gate.open()
	
func _on_spawn_trigger_zone_body_entered(body: Node3D) -> void:
	if hasSpawned:
		return
		
	if body.is_in_group("Player"):
		Spawn()
		

func Spawn():
	for point in spawnPoints:
		SpawnEnemyAt(point)
		
	hasSpawned = true
	
func SpawnEnemyAt(targetPoint : Node):
	var enemyToSpawn = preload("res://Game/Scenes/Enemy.tscn")
	var enemyInstance = enemyToSpawn.instantiate()
	get_tree().get_root().get_node("GameScene").add_child(enemyInstance)
	enemyInstance.global_position = targetPoint.global_position
	enemyNodes.append(enemyInstance)
