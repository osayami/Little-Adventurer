class_name Portal
extends Node3D
@export var coinRequired : int = 12
@onready var textlabel: Label = $Sprite3D/SubViewport/Label
signal playerReachedThePortal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textlabel.text = str(coinRequired)




func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if body.coinNumber >= coinRequired:
			#print("The player has reached the portal")
			emit_signal("playerReachedThePortal")
		
