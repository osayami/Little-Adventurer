extends Node3D

@export var player : PlayerCharacter
@export var gameUIManager : GameUIManager
@onready var portal : Portal = $Portal

var paused : bool :
	set(new_value):
		paused = new_value
		gameUIManager.togglePauseUI(paused)
		get_tree().paused = paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	portal.playerReachedThePortal.connect(gameIsFinished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		paused = true
	
	if player.isDead:
		gameOver()

func gameIsFinished():
	get_tree().paused = true
	gameUIManager.toggleGameFinishUI(true)
	
func gameOver():
	get_tree().paused = true
	gameUIManager.toggleGameOverUI(true)

func _on_button_restart_button_up() -> void:
	#for scene in get_tree().root.get_children():
		#scene.queue_free()
		
	get_tree().paused = false
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()

func _on_button_main_menu_button_up() -> void:
	#for scene in get_tree().root.get_children():
		#scene.queue_free()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Game/Scenes/MainScene.tscn")
		
	

func _on_button_resume_button_up() -> void:
	paused = false
