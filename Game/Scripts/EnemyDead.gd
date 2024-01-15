extends StateBase

@export var collisionShape3d: CollisionShape3D
@export var materialEffectAnimationPlayer : AnimationPlayer


func enter():
	super.enter()
	character.velocity = Vector3.ZERO
	collisionShape3d.disabled = true
	await get_tree().create_timer(1).timeout
	materialEffectAnimationPlayer.play("Dead")
	await get_tree().create_timer(3).timeout
	
	var dropItem = preload("res://Game/Scenes/collectalbe_healing_orb.tscn")
	var dropItemInstance = dropItem.instantiate()
	get_tree().get_root().get_node("GameScene").add_child(dropItemInstance)
	dropItemInstance.global_position = character.global_position
	
	character.queue_free()
