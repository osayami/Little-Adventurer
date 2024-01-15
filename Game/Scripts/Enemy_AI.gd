extends CharacterBody3D

const SPEED = 0.5

@onready var navAgent: NavigationAgent3D = $NavigationAgent3D
@onready var visualNode: Node3D = $VisualNode
@onready var animation_player: AnimationPlayer = $VisualNode/AnimationPlayer
@onready var material_effect_animation_player: AnimationPlayer = $VisualNode/MaterialEffectAnimationPlayer


var player: CharacterBody3D 
var direction : Vector3
var maxHealth : int = 100
var currentHealth : int



func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	currentHealth = maxHealth
	
func _physics_process(delta: float) -> void:
	
	move_and_slide()

func applyDamage(damage : int):
	currentHealth -= damage
	currentHealth = clamp(currentHealth , 0 , maxHealth)
	#print("currentHealth =" , currentHealth)
	material_effect_animation_player.play("Flash")
