extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


	
func open():
	animation_player.play("Open")
