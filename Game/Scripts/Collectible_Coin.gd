extends Node3D

@onready var visual: Node3D = $VisualNode
@onready var pickupVfx: GPUParticles3D = $VFXNode
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var rotateSpeed = 1
var coinValue = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visual.rotate_y(rotateSpeed * delta)
	if not visual.visible && not pickupVfx.emitting:
		queue_free()
		

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		pickupVfx.emitting= true
		animation_player.play("Collected")
		
		body.AddCoin(coinValue)
