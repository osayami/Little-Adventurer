class_name PlayerCharacter
extends CharacterBody3D


const SPEED = 5.0
var direction : Vector3
var slideKey_pressed : bool
var attackKey_pressed : bool
var isDead : bool

var maxHealth : int = 100
var currentHealth : int :
	set(new_value):
		currentHealth = new_value
		emit_signal("playerHealthUpdated" , currentHealth , maxHealth)

@onready var visual: Node3D = $VisualNode
@onready var animation_player: AnimationPlayer = $VisualNode/AnimationPlayer
@onready var footstepVFX: GPUParticles3D = $VisualNode/VFX/Footstep_GPUParticles3D
@onready var footStepSFX: AudioStreamPlayer3D = $VisualNode/VFX/AudioStreamPlayer3D
@onready var swordSlashSFX: AudioStreamPlayer3D = $VisualNode/VFX/SwordSlashSFX

var coinNumber :int:
	set(new_value):
		coinNumber = new_value
		emit_signal("coinNumberUpdated", coinNumber)
		

signal coinNumberUpdated(newValue)
signal playerHealthUpdated(newValue , maxValue)

func _ready() -> void:
	currentHealth = maxHealth

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= 1


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	slideKey_pressed = Input.is_action_just_pressed("Slide")
	attackKey_pressed = Input.is_action_just_pressed("Attack")
	move_and_slide()

func AddCoin(value : int):
	coinNumber += value
	#aprint(coinNumber)
	
func takeDamage(damage:int , enemy_position:Vector3):
	currentHealth -= damage
	currentHealth = clamp(currentHealth , 0 , maxHealth)
	#print("The player took damage:", damage ,"Current health :",currentHealth)
	
	get_node("StateMachine").switchTo("Hurt")
	
	if get_node("StateMachine").current_state.name == "Hurt":
		get_node("StateMachine").current_state.pushBackDir = (global_position - enemy_position ).normalized()


func addHealth(value:int):
	currentHealth += value
	currentHealth = clamp(currentHealth , 0 , maxHealth)
	
func playFootStepsSFX():
	footStepSFX.pitch_scale = randf_range(0.8 , 1.2)
	footStepSFX.play()
	
func playSwordSlashSFX():
	#swordSlashSFX.pitch_scale = randf_range(0.8 , 1.2)
	swordSlashSFX.play()
