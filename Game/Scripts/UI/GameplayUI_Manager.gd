class_name GameUIManager
extends Node3D

@onready var coinLabel: Label = $Control_GameplayUI/HBoxContainer_Coin/Label_Coin
@onready var healthBar: ProgressBar =$Control_GameplayUI/HBoxContainer_Health/ProgressBar
@onready var blackColorRect: ColorRect = $Control_Game/ColorRect

@export var player: CharacterBody3D 
@onready var gamePause: Container = $Control_Game/GamePause
@onready var gameOver: Container = $Control_Game/GameOver
@onready var gameFinish: Container = $Control_Game/GameFinish

func togglePauseUI(toggle:bool):
	blackColorRect.visible = toggle
	gamePause.visible = toggle

func toggleGameOverUI(toggle:bool):
	blackColorRect.visible = toggle
	gameOver.visible = toggle
	
func toggleGameFinishUI(toggle:bool):
	blackColorRect.visible = toggle
	gameFinish.visible = toggle
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.coinNumberUpdated.connect(UpdateCoinLabel)
	updateHealthBar(player.currentHealth,player.maxHealth)
	player.playerHealthUpdated.connect(updateHealthBar)
	
	toggleGameFinishUI(false)
	toggleGameOverUI(false)
	togglePauseUI(false)
	


func UpdateCoinLabel(newValue : int):
	coinLabel.text = str(newValue)

func updateHealthBar(newValue : int , maxValue : int):
	var value = float(newValue) / float (maxValue) * 100
	healthBar.value = int(value)
