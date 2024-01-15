extends Node3D

var healthValue : int = 10
@onready var visual: Node3D = $VisualNode
@onready var vfxAnimationPlayer: AnimationPlayer = $VFX/AnimationPlayer


func _process(delta: float) -> void:
	if visual.visible and vfxAnimationPlayer.is_playing():
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"): 
		body.addHealth(healthValue)
		visual.visible = false
		vfxAnimationPlayer.play("PlayParticle")
		
